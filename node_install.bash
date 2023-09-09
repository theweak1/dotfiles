#!/usr/bin/env bash

echo -e "\n<<< Running $0 >>>\n"

# Check if n is installed
echo -e "\n<<< Checking if n is installed. >>>\n"
if ! command -v "n" &> /dev/null; then
  echo "n is not installed. Installing..."
  curl -L https://bit.ly/n-install | bash
  mv $HOME/n $HOME/.n
else
  echo "n is already installed."
fi

echo -e "\n<<< node setup finished. >>>\n"

