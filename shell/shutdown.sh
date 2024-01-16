#!/bin/zsh

PIDS=$(lsof -t -i :8000)

if [ -z "$PIDS" ]; then
    echo "No processes are listening on port 8000."
else
    echo "Processes listening on port 8000: $PIDS"
    kill $PIDS
    CURRENT_PIDS=$(lsof -t -i :8000)
    if [ -z "$CURRENT_PIDS" ]; then
      echo "Shutdown successful."
    else
      echo "Shutdown failed – processes $CURRENT_PIDS remain."
    fi
fi

