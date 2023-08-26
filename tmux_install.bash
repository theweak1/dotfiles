#!/usr/bin/env bash

echo "Running Tmux setup"
# Check if Tmux is installed
if ! command -v "tmux" &> /dev/null; then
  echo "tmux is not installed. Installing..."
  sudo apt install tmux
else
  echo "tmux is already installed."
fi

echo "Checking if TPM is installed..."
if [ -d ~/.tmux/plugins/tpm ]; then
  echo "TPM is already installed."
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "TPM installed successfully."
fi

echo "tmux.bash finished."

