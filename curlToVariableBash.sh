#!/bin/bash

# text color
RED='\033[0;31m'   # RED
BLUE='\033[0;34m'  # Blue
GREEN="\033[0;32m" # Green
ITALICGREEN="\e[3;${GREEN}"
NC='\033[0m'       # No Color

# Underline color
UCyan='\033[4;36m' # Cyan

datesToCall=($@)

# Validate if any date are passed
if [[ ${#datesToCall[@]} -eq 0 ]]
then
  printf "${BLUE}Provide dates!! (format: AAAA-MM-DD). Ex.: ./script.sh 2021-06-20 2021-06-20 [....]${NC}\n" 1>&2
  exit 0
fi

## Validate dates
function validateDates() {
  for t in ${datesToCall[@]}; do
    if ! date -d "$t" >/dev/null 2>&1 || ! [[ "$t" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]
    then
      printf "${RED} the date ${UCyan}${t}${RED} are in wrong format${NC}\n" 1>&2
      exit 1
    fi
  done
  printf "${ITALICGREEN}All dates are OK!${NC}\n" 1>&2
}

printf "${BLUE}Validating dates...${NC}\n" 1>&2
validateDates


# get 
arrLen=${#datesToCall[@]}
i=0

printf "${BLUE}Calling configured dates:${NC}\n" 1>&2

# Call all dates
for dt in "${datesToCall[@]}";
do
  printf "${GREEN}=======================================${RED}\n$((i+1))/${arrLen}${NC} - Calling endpoint with date: ${RED}${datesToCall[$i-1]}${NC} - Endpoint: ${UCyan}http://localhost:8085/run-clean-integration/88972601-ecc9-48ba-a56d-60b071f184a5/${dt}${NC}\n" 1>&2
  response=$(curl -X GET http://localhost:8085/run-clean-integration/88972601-ecc9-48ba-a56d-60b071f184a5/${dt} )
  printf "\n${BLUE}Curl Response${NC}: \n${GREEN}${response}${NC}\n\n"
  i=`expr $i + 1`
done

exit 0