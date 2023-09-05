#!/usr/bin/env bash

echo -e "\n<<< Starting $0 >>>\n"

#check if bat is installed
echo -e "\n<<< Checking if bat is installed. >>>\n"
if ! command -v "batcat" &> /dev/null; then
  echo "bat is not installed. Installing..."
  sudo apt install bat -y
else
  echo "bat is already installed."
fi

#check if pip isnstall
echo -e "\n<<< Checking if pip3 is installed. >>>\n"
if ! command -v "pip3" &> /dev/null; then
  echo "pip3 is not installed. Installing..."
  sudo apt install python3-pip -y
else
  echo "pip3 is already installed."
fi

echo -e "\n<<< software install finished. >>>\n"
