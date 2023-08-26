#!/usr/bin/env bash

echo "Running fish_install.bash"

# Check if fish is installed
if ! command -v "fish" &> /dev/null; then
  echo "fish is not installed. Installing..."
  sudo apt update
  sudo apt-add-repository ppa:fish-shell/release-3
  sudo apt update
  sudo apt-get install fish -y
  chsh -s /usr/bin/fish
  sudo apt install exa -y
else
  echo "fish is already installed."
fi

echo "checking if fisher is installed..."
if [ -d ~/.config/fish/functions/fisher.fish ] || [ -d ~/.config/fish/completions/fisher.fish ]; then
  echo "fisher is already installed."
else
  echo "Installing fisher..."
  # Remove conflicting files
  rm -f ~/.config/fish/functions/fisher.fish ~/.config/fish/completions/fisher.fish
  # Install fisher
  fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
  echo "fisher installed successfully."
fi

echo "checking if tide is installed..."
if fish -c "functions -q tide"; then
  echo "tide is already installed."
else
  echo "Installing tide..."
  fish -c "fisher install IlanCosman/tide@v5"
fi

rm -f ~/.config/fish/fish_variables
echo "fish_install.bash finished."

