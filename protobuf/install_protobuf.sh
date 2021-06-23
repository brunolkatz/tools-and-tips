#!/usr/bin/env bash

go get -u github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway &&
  go get -u github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2 &&
  go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc &&
  go get -u google.golang.org/protobuf/cmd/protoc-gen-go
