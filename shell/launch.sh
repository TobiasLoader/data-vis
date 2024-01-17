#!/bin/zsh

PORT=8000

case $# in
  0)
    echo "Build projects ready for launch:"
    path="$(pwd)/builds"
    for dir in "$path"/*; do
      if [ -d "$dir" ]; then
        echo " - ${dir:t}"
      fi
    done
    ;;
  1)
    # Check if the path exists and is a directory
    if [[ -d "builds/$1" ]]; then
      # Check if a process on port 8000 is already open (python server)
      if lsof -i :$PORT > /dev/null 2>&1; then
        # open build straight away (no need to launch python server)
        open "http://localhost:8000/builds/$1"
      else
        # otherwise launch python simple server then open build
        echo "[ launching server... ]"
        python -m SimpleHTTPServer & sleep 2; open "http://localhost:8000/builds/$1"
      fi
      if [ $? -eq 0 ]; then
        echo "Project '$1' has been launched successfully."
        echo "--"
      else
        echo "Failed to launch project '$1'."
      fi
    else
      echo "'$1' is not a build in the '/builds' folder."
      echo "run 'launch' to view list of builds ready to launch"
    fi
    ;;
  *)
    echo "Error: Too many parameters. Please provide none or one."
    ;;
esac