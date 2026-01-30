function checkProtoVersion() {
  # check version
  version=$(protoc --version)
  if [ "$version" != "libprotoc 29.3" ]; then
    log::error "Your protoc version is $version, please install libprotoc 29.3"
    log::info "Run the following command to install:\n" \
    brew uninstall protobuf && brew install ./script/protobuf.rb
    exit 1
  fi

  # check version
  version=$(protoc-gen-go --version)
  if [ "$version" != "protoc-gen-go v1.36.6" ]; then
    log::info "Your protoc-gen-go version is $version, installing protoc-gen-go v1.36.6"
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.36.6
  fi

  # check version
  version=$(protoc-gen-go-grpc -version)
  if [ "$version" != "protoc-gen-go-grpc 1.5.1" ]; then
    log::info "Your protoc-gen-go-grpc version is $version, installing protoc-gen-go-grpc 1.5.1"
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.5.1
  fi

}


function checkMockVersion() {
    # check version
    version=$(mockgen -version)
    if [ "$version" != "v0.5.2" ]; then
      log::info "mockgen version is $version, installing mockgen v0.5.2"
      go install go.uber.org/mock/mockgen@v0.5.2
    fi
}
