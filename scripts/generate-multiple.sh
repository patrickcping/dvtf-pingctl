#!/bin/bash

# Directory containing the files
directory="/Users/patrickcowland/Documents/ping-integration-example-packages/davinci-oidc_sdk-ciam_passwordless_solution-pkg/terraform/davinci-flows"

# Initialize the command variable
command="go run ./ generate -o ./testoutput"

# Loop through all files in the directory
for file in "$directory"/*.json; do
  # Add each file as a parameter
  command+=" -e $file"
done

# Execute the command
eval $command