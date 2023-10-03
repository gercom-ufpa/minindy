#!/bin/bash

export PATH=${PWD}/../bin:${PWD}:$PATH
export INDY_CFG_PATH=${PWD}
export VERBOSE=true
export DOCKER_API_VERSION=1.39

. scripts/mainfuncs.sh

MODE=$1
shift

while [[ $# -gt 0 ]]; do
optkey="$1"

case $optkey in
  -h|--help)
    printHelp; exit 0;;
  -s|--steward)
    CURRENT_ORG="$2";shift;shift;;
  -e|--expose-endpoints)
    EXPOSE_ENDPOINTS="$2";shift;shift;;
  -f|--run-output)
    RUN_OUTPUT="$2";shift;shift;;
  -a|--target-environment)
    TARGET_ENV="$2";shift;shift;;
  *) # unknown option
    echo "$1 is a not supported option"; exit 1;;
esac
done

isValidateCMD

doDefaults

echo "MinIndy Execution Context:"
echo "    INDY_RELEASE=$IMAGETAG"
echo "    EXPOSE_ENDPOINTS=$EXPOSE_ENDPOINTS"
echo "    EXPOSE_ENDPOINTS=$EXPOSE_ENDPOINTS"
echo "    CURRENT_STWD=$CURRENT_ORG"
echo "    HOST_ADDRESSES=$ADDRS"
echo "    TARGET_ENV=$TARGET_ENV"

getRealRootDir

echo "    WORKING_DIRECTORY: $hostroot"

startMinIndy
