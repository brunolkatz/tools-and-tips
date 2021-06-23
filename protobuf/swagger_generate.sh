#!/usr/bin/env bash

# Generate swagger files

protoc -I. \
  -I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  -I"$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/" \
  --swagger_out=logtostderr=true:docs \
  $(find "." -not \( -path ./docs -prune \) -name \*.proto)
