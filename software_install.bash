#!/usr/bin/env bash

echo -e "\n<<< Starting $0 >>>\n"

#check if bat is installed
echo -e "\n<<< Checking if bat is installed. >>>\n"
if ! command -v "bat" &> /dev/null; then
  echo "bat is not installed. Installing..."
 wget -O ~/Downloads/bat-musl_0.23.0_amd64.deb https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-musl_0.23.0_amd64.deb 
if [ -e ~/Downloads/bat-musl_0.23.0_amd64.deb ]; then
  sudo dpkg -i ~/Downloads/bat-musl_0.23.0_amd64.deb
  rm ~/Downloads/bat-musl_0.23.0_amd64.deb
  fi
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

#check if exa is installed
echo -e "\n<<< Checking if exa is installed. >>>\n"
if [ -x "$(command -v exa)" ]; then
  echo "exa is already installed."
else
  echo "exa is not installed. Installing exa..."
  sudo apt install exa -y
fi

echo -e "\n<<< software install finished. >>>\n"
