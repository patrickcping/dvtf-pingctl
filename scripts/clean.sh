#!/usr/bin/env bash

DIR="./testoutput"

if [ -d "$DIR" ]; then
  echo "Directory $DIR exists. Removing it."
  rm -r "$DIR"
else
  echo "Directory $DIR does not exist."
fi