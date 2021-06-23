#!/usr/bin/env bash

# text color
RED='\033[0;31m'   # RED
BLUE='\033[0;34m'  # Blue
NC='\033[0m'       # No Color

# Underline color
UCyan='\033[4;36m' # Cyan

if ! [[ -f "make-proto.config" ]]; then
  printf "${RED}please provide the make-proto.config file${NC}\n"
  exit 1
fi

# import make-proto.config file to environments variables
source make-proto.config
if [[ -z "$APIS_BUILD" ]]; then
  printf "${RED}Please provide into ${UCyan}make-proto.config${RED} file the ${UCyan}\"APIS_BUILD\"${NC}${RED} variable with the api folders can be build${NC}\n" 1>&2
  exit 1
fi
if [[ -z "$DST_DIR" ]]; then
  printf "${RED}Please provide into ${UCyan}make-proto.config${RED} file the ${UCyan}\"DST_DIR\"${NC}${RED} variable${NC}\n" 1>&2
  exit 1
fi
if [[ -z "$SRC_DIR" ]]; then
  printf "${RED}Please provide into ${UCyan}make-proto.config${RED} file the ${UCyan}\"SRC_DIR\"${NC}${RED} variable${NC}\n" 1>&2
  exit 1
fi

echo "-------------->>>>>>>> V1.0 Make Protos"
printf "Compiling all proto files in ${SRC_DIR} folder\n"
echo "-------------->>>>>>>>"

# Compile proto file
# $1 = Filename to compile
function compile() {
  protoc -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway \
    -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    --go_out=$DST_DIR --proto_path=proto --go_opt=M$1=services \
    --go_opt=paths=import --go-grpc_out=. \
    $1
}

## Validate api_build's
function validateApiBuilds() {
  for t in ${APIS_BUILD[@]}; do
    if ! [[ "$t" =~ ^[^\/]*\/v[-0-9]+(\/.*?)*$ ]]; then
      printf "${RED}The API_BUILD value ${UCyan}\"${t}\"${RED} are declare wrong, please declare ${UCyan}[api_folder]/[version_folder][/.....]${RED} (example: prototest/v1)${NC}\n" 1>&2
      exit 1
    fi
  done
}

validateApiBuilds

while IFS= read -r -d '' filename; do
  [ -e "$filename" ] || continue
  # verify if this folder can be build
  compileThis=false
  for t in ${APIS_BUILD[@]}; do
    if [[ $(dirname $filename) == *t* ]]; then
      compileThis=true
    fi
  done
  if [ $compileThis = "true" ]; then
    printf "${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}\n"
    printf "Generating protofile for: $filename\n"
    printf "Generating the file: ${UCyan}$(basename "$filename" .proto).pb.go${NC} and ${BLUE}${UCyan}$(basename "$filename" .proto)_grpc.pb.go${NC}\n"
    printf "${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}\n"
    compile $filename
  fi
done < <(find "$SRC_DIR" -name '*.proto' -print0)
