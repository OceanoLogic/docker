#!/bin/bash

if ! command -v aws &> /dev/null
then
    echo "AWS ClI not found. Please install the AWS CLI"
    exit
fi

docker build --progress=plain --no-cache -t local/glue_dcoe:3.16.0.dev1 .
