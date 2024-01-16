#!/bin/zsh

PORT=8000

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
    if lsof -i :$PORT > /dev/null 2>&1; then
      open "http://localhost:8000/builds/$1"
    else
      echo "[ launching server... ]"
      python -m SimpleHTTPServer & sleep 2; open "http://localhost:8000/builds/$1"
    fi
    if [ $? -eq 0 ]; then
      echo "Project '$1' has been launched successfully."
      echo "--"
    else
      echo "Failed to launch project '$1'."
    fi
    ;;
  *)
    echo "Error: Too many parameters. Please provide none or one."
    ;;
esac