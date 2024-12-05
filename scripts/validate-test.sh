#!/usr/bin/env bash

# Directory containing the files
directory=$1

# Initialize the command variable
command="go run ./ validate"

# Loop through all files in the directory
for file in "$directory"/*.json; do
  # Add each file as a parameter
  command+=" -e \"$file\""
done

# Execute the command
eval $command