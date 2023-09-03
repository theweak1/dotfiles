#!/usr/bin/env bash

echo "Running additional software_install.bash"

#check if bat is installed
if ! command -v "batcat" &> /dev/null; then
  echo "bat is not installed. Installing..."
  sudo apt install bat -y
else
  echo "bat is already installed."
fi

#check if pip isnstall
if ! command -v "pip3" &> /dev/null; then
  echo "pip3 is not installed. Installing..."
  sudo apt install python3-pip -y
else
  echo "pip3 is already installed."
fi

echo "software_install.bash finished."
