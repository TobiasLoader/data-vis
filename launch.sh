#!/bin/bash

case $# in
  0)
    echo "Build projects ready for launch:"
    path="$(pwd)/builds"
    for dir in "$path"/*; do
      if [ -d "$dir" ]; then
        echo " - $(basename "$dir")"
      fi
    done
    ;;
  1)
    open "builds/$1/index.html"
    if [ $? -eq 0 ]; then
      echo "Project '$1' has been launched successfully."
    else
      echo "Failed to launch project '$1'."
    fi
    ;;
  *)
    echo "Error: Too many parameters. Please provide none or one."
    ;;
esac