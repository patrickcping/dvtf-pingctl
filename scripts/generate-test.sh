#!/usr/bin/env bash

go build .

# Directory containing the files
directory=$1

# Directory containing the script
script_dir=$(dirname "$(realpath "$0")")

# Directory to generate HCL in
MAIN_DIR="$directory/testoutput"
MODULE_DIR="$MAIN_DIR/module"

if [ -d "$MAIN_DIR" ]; then
  echo "Directory $MAIN_DIR exists.  Removing it."
  rm -r $MAIN_DIR
fi

# Initialize the command variable
command=""

# Loop through all JSON (export) files in the directory
for file in "$directory"/*.json; do

  # ./dvtf-pingctl validate -e "$file"
  # validateResponse=$?
  # # Check if the command failed
  # if [ $validateResponse -eq 1 ]; then
  #   echo "Validation failed"
  #   exit 1
  # fi
  # if [ $validateResponse -eq 2 ]; then
  #   echo "Validation warning"
  # fi

  # Add each file as a parameter
  command+=" -e \"$file\""
done

set -e

# Execute the command
./dvtf-pingctl generate -o $MODULE_DIR $command

if [ -d "$MAIN_DIR" ]; then
  echo "Directory $MAIN_DIR exists.  Bootstrapping it."

  # cp $script_dir/../testing/bootstrap-hcl/* $DIR
  cp $directory/*.tftest.hcl $MAIN_DIR
  cp $directory/versions.tf $MAIN_DIR
  
  pushd $MAIN_DIR
    terraform init
    pushd $MODULE_DIR
      tflint
      terraform validate
    popd
    terraform test
  popd
else
  echo "Directory $MAIN_DIR does not exist."
  exit 1
fi