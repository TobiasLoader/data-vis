#!/bin/bash

read -p "Are you sure you wish to delete '$1' (Y/n): " check

if [ $check = "Y" ]; then
  rm -r "builds/$1"
  echo "Project '$1' has been deleted."
else
  echo "Project '$1' will not be deleted."
fi