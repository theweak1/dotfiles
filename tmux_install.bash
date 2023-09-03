#!/usr/bin/env bash

echo -e "\n<<< Running tmux setup >>>\n"
# Check if Tmux is installed
echo -e "\n<<< Checking if tmux is installed. >>>\n"
if ! command -v "tmux" &> /dev/null; then
  echo "tmux is not installed. Installing..."
  sudo apt install tmux -y
else
  echo "tmux is already installed."
fi

#Check if TMP is installed
echo -e "\n<<< Checking if TMP is installed. >>>\n"
if [ -d ~/.tmux/plugins/tpm ]; then
  echo "TPM is already installed."
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "TPM installed successfully."
fi

echo -e "\n<<< tmux setup finished. >>>\n"

