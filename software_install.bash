#!/usr/bin/env bash

echo "Running additional software_install.bash"

#check if bat is installed
if ! command -v "batcat" &> /dev/null; then
  echo "bat is not installed. Installing..."
  sudo apt install bat -y
else
  echo "bat is already installed."
fi


echo "software_install.bash finished."
