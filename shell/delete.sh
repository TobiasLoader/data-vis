#!/bin/zsh

echo -n "Are you sure you wish to delete '$1' (Y/n): "
read check

if [ $check = "Y" ]; then
  rm -r "builds/$1"
  echo "Project '$1' has been deleted."
else
  echo "Project '$1' will not be deleted."
fi