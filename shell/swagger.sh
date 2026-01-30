#!/usr/bin/env bash
set -e

APIDIR="api/proto"

if [ -n "$1" ]; then
   APIDIR=$(find "$APIDIR" -type d -path "*/$1")
fi

# 获取拥有*.proto的目录
PROTO_DIR=$(find ${APIDIR} -name "*.proto" -exec dirname {} \; | sort | uniq)
for file in ${PROTO_DIR};
do
  protofiles=$(find ${file} -maxdepth 1 -name *.proto);
  protoc --proto_path=./api/proto \
  --proto_path=./third_party \
  --openapi_out=title=API文档,enum_type=string,naming=proto,default_response=false:${file} \
  ${protofiles} \
  && echo "swagger ${file} generate success"; \
done;

# 过滤openapi.yaml文件中包含"paths: {}"的文件
OPENAPI_FILES=$(find ${APIDIR} -name "*.yaml")
for file in ${OPENAPI_FILES};
do
  if grep -q "paths: {}" ${file}; then
    rm -f "${file}"
  fi
done;
