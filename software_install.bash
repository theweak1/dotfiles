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
  # Check if Rust and Cargo are installed
  if ! [ -x "$(command -v cargo)" ];then
    echo "Installing Rust and Cargo..."
    sudo apt update
    sudo apt install rustc cargo -y
  fi

  #Install exa using Cargo
  echo "Installing exa..."
  cargo install exa

  # Add Cargo bin directory to PATH (if not already added)
  if ! grep -q "$HOME/.cargo/bin" "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$HOME/.bashrc"
    source "$HOME/.bashrc"
  fi
fi

echo -e "\n<<< software install finished. >>>\n"
