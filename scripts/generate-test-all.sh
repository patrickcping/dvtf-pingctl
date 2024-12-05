#!/usr/bin/env bash

set -e  # Exit immediately if a command exits with a non-zero status

script_dir=$(dirname "$(realpath "$0")")
echo $script_dir

ls $script_dir/../testing/test-cases

for dir in "$script_dir/../testing/test-cases"/*/; do
  if [ -d "$dir" ]; then
    echo "Running generate-test.sh in $dir"
    $script_dir/generate-test.sh $dir
  fi
done
