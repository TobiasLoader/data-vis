#!/bin/zsh

echo -n "Are you sure you wish to delete '$1' (Y/n): "
read check

if [ $check = "Y" ]; then
  # remove the build
  rm -r "builds/$1"
  
  # remove from metadata.json
  jq "del(.$1)" metadata.json > temp.json && mv temp.json metadata.json
  
  if [ $? -eq 0 ]; then
    echo "Project '$1' has been deleted."
  else
    echo "Project '$1' failed to delete."
  fi
else
  echo "Project '$1' will not be deleted."
fi