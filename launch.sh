#!/bin/bash

open "builds/$1/index.html"

if [ $? -eq 0 ]; then
  echo "Project '$1' has been launched successfully."
else
  echo "Failed to launch project '$1'."
fi