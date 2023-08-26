#!/usr/bin/env bash

echo "Running fish_install.bash"

# Check if fish is fish is installed
if ! command -v "fish" &> /dev/null; then
  echo "fish is not installed. Installing..."
  sudo apt update
  sudo apt-add-repository ppa:fish-shell/release-3
  sudo apt update
  sudo apt-get install fish -y
  sudo chsh -s /usr/bin/fish
  sudo apt install exa -y
else
  echo "fish is already installed."
fi


echo "checking if fisher is installed..."
if [ -d ~/.config/fish/functions/fisher.fish ] || [-d ~/.config/fish/completions/fisher.fish]; then
  echo "fisher is already installed."
else
  echo "Installing fisher..."
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
  echo "fisher installed successfully."
fi

echo "checking if tide is installed..."
if [ -d  ~/.config/fish/functions/tide ]; then
  echo "tide is already installed."
else
  echo "Installing tide..."
  fisher install IlanCosman/tide@v5
fi


echo "fish_install.bash finished."
