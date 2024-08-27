#!/usr/bin/env bash

DIR="./testoutput"

if [ -d "$DIR" ]; then
  echo "Directory $DIR exists.  Bootstrapping it."

  cp scripts/test-bootstrap-hcl/* $DIR
  
  pushd $DIR
    terraform init
    terraform validate
    terraform plan -out infra.tfout
  popd
else
  echo "Directory $DIR does not exist."
fi