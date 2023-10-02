#!/bin/bash

# Check if sudo is installed
echo -e "\n<<< Checking if sudo is installed. >>>\n"
if ! command -v "sudo" &> /dev/null; then
    echo "sudo is not installed. Installing..."
    apt update && apt install -y sudo
else
  echo "sudo is already installed."
fi

sudo apt update

sudo apt install -y git unzip wget curl python3 pip vim fontconfig

sudo apt upgrade -y
