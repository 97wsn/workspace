#!/usr/bin/env bash
set -e

APIDIR="api/proto"

if [ -n "$1" ]; then
  APIDIR=$(find "$APIDIR" -type d -path "*/$1")
fi

loadVersion && checkProtoVersion

echo "[Generate proto dir]${APIDIR}"

OPENAPI_PROTO_FILES=$(find ${APIDIR} -name *.proto | grep -v error_reason.proto)
ERROR_PROTO_FILES=$(find ${APIDIR} -name error_reason.proto)
APIGOMODULE=$(head -1 api/go.mod | cut -d' ' -f2)

# generate proto files
if [ -n "${OPENAPI_PROTO_FILES}" ]; then
  protoc --proto_path=./api/proto \
    --proto_path=./third_party \
    --go_out=module=${APIGOMODULE}:./api \
    --go-grpc_out=module=${APIGOMODULE},require_unimplemented_servers=false:./api \
    --validate_out=module=${APIGOMODULE},lang=go:./api \
    ${OPENAPI_PROTO_FILES}
  if [ $? -ne 0 ]; then
    echo "protoc grpc generate failed"
    exit 1
  fi
  echo "protoc grpc generate success"
fi


# generate error proto files
if [ -n "${ERROR_PROTO_FILES}" ]; then
  protoc --proto_path=./api/proto \
    --proto_path=./third_party \
    --go_out=module=${APIGOMODULE}:./api \
    --go-errors_out=module=${APIGOMODULE}:./api \
    ${ERROR_PROTO_FILES}
  if [ $? -ne 0 ]; then
    echo "protoc errcode generate failed"
    exit 1
  fi
  echo "protoc errcode generate success"
fi

