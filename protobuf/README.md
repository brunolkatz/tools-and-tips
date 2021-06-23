Project: boilerplate-protofiles-apis
------------------------

- All protofiles for each support service in [project] microservices

Design
-------

- Create a folder for each new API
- Inside the folder create a ```V[n]``` (```n``` identify the version)
- Inside your ```V[n]``` folder create yours protofiles
- Example:
  - ```blog``` -> ```v1``` -> ```posts``` => ```blog_posts.proto```

Tips
----

- If you are using protobuf files for generate server ```Go``` files, use the ```option go_package``` into
  ```proto``` files, this will determine the package of generated files in ```Go```
    - Example: ```option go_package = "/services";```

Informations about Protobuf
---------------------------

- Language guide: https://developers.google.com/protocol-buffers/docs/proto3

Generating Swagger Documentation (Linux and Ubuntu for WSL 2)
--------------------------------

- Installs:
    - ```shell script
      go install \
          github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
          github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2 \
          google.golang.org/protobuf/cmd/protoc-gen-go \
          google.golang.org/grpc/cmd/protoc-gen-go-grpc \
          github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
      ```
    - After install: ```go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger```
    - Install too: ```sudo apt install libprotobuf-dev libprotoc-dev```
    - Make sure you have the ```GOBIN``` in the path: ```export GOBIN="$GOPATH/bin"```
    - If you are using Goland (jetbrains IDE) install the plugin: ```Protocol Buffer Editor``` for get intellisense when
      you are writing ```.proto``` files
        - Include in ```configuration --> Languages & Frameworks --> Protocol Buffer``` for add auto-complete code in
          editor:
        - ```shell
          file:///$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway
          file:///$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis
          ```
- Then run: ```swagger_generate.sh```
    - If the error ```protoc-gen-openapiv2/options/annotations.proto: File not found.``` appears,
      see: https://github.com/grpc-ecosystem/grpc-gateway/issues/976
    - This will create a ```docs.swagger.json``` file into ```docs``` folder

Info
----

- More info into:
    - tips: https://medium.com/golang-diary/7-tips-when-working-with-grpc-gateways-swagger-support-afa0c2d671d8
    - ```grpc-gateway``` documentation: https://grpc-ecosystem.github.io/grpc-gateway/


Protofile Example
-----------------

```sh
import "google/api/annotations.proto";
import "google/protobuf/timestamp.proto";
import "google/api/field_behavior.proto";
import "protoc-gen-openapiv2/options/annotations.proto";

option go_package = "/services";
package proto;

// Swagger header documents
option (grpc.gateway.protoc_gen_openapiv2.options.openapiv2_swagger) = {
  info: {
    title: "Cobranças Protobuf Apis";
    version: "0.1.0";
    contact: {
      name: "gRPC-Gateway project";
      url: "https://github.com/grpc-ecosystem/grpc-gateway";
      email: "none@example.com";
    };
  };
};

message MakeRevenuesRequest {
  uint64 monthRevenue = 1 [(google.api.field_behavior) = REQUIRED, json_name = "month_revenue"];
  uint64 yearRevenue = 2 [(google.api.field_behavior) = REQUIRED, json_name = "year_revenue"];
  uint64 userCode = 3 [(google.api.field_behavior) = REQUIRED, json_name = "user_code"];
  google.protobuf.Timestamp processTime = 4 [(google.api.field_behavior) = REQUIRED, json_name = "process_time"];
  google.protobuf.Timestamp initialCompetenceDate = 5 [(google.api.field_behavior) = REQUIRED, json_name = "initial_ticketing_date"];
  google.protobuf.Timestamp finalCompetenceDate = 6 [(google.api.field_behavior) = REQUIRED, json_name = "final_ticketing_date"];
}

message MakeRevenuesResponse {
  uint32 code = 1;
  string message = 2;
}

message StartClientRevenueRequest {
  uint32 codcobrancascliente = 1 [(google.api.field_behavior) = REQUIRED, json_name = "codcobrancascliente"];
  uint32 monthRevenue = 2 [(google.api.field_behavior) = REQUIRED, json_name = "month_revenue"];
  uint32 yearRevenue = 3 [(google.api.field_behavior) = REQUIRED, json_name = "year_revenue"];
  uint32 userCode = 4 [(google.api.field_behavior) = REQUIRED, json_name = "user_code"];
  google.protobuf.Timestamp processTime = 5 [(google.api.field_behavior) = REQUIRED, json_name = "process_time"];
  google.protobuf.Timestamp initialCompetenceDate = 6 [(google.api.field_behavior) = REQUIRED, json_name = "initial_ticketing_date"];
  google.protobuf.Timestamp finalCompetenceDate = 7 [(google.api.field_behavior) = REQUIRED, json_name = "final_ticketing_date"];
}

message StartClientRevenueResponse {
  uint32 code = 1;
  string message = 2;
}


service revenues {
  rpc StartAll(MakeRevenuesRequest) returns (MakeRevenuesResponse) {
    option (google.api.http) = {
      post: "revenues/v1/startall"
    };
  };
  rpc StartClientRevenue(StartClientRevenueRequest) returns (StartClientRevenueResponse) {
    option (google.api.http) = {
      post: "revenues/v1/startClientRevenue"
    };
  };
}
```