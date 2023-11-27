#!/usr/bin/env bash

echo  -e "\n<<< Running $0 >>>\n"

# Check if fish is installed
echo -e "\n<<< Checking if fish is installed >>>\n"
if ! command -v "fish" &> /dev/null; then
  echo "fish is not installed. Installing..."
  sudo apt update
  sudo apt-add-repository ppa:fish-shell/release-3
  sudo apt update
  sudo apt-get install fish -y
  echo "Please enter sudo password to change default shell to fish"
  chsh -s /usr/bin/fish
else
  echo "fish is already installed."
fi

echo -e "\n<<< checking if fisher is installed >>>\n"
if ! fish -c "type fisher" &> /dev/null; then
  echo "Installing fisher..."
  fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
  echo "fisher installed successfully."
else
  echo "fisher is already installed."
fi

# echo -e "\n<<< checking if tide is installed >>>\n"
# if fish -c "functions -q tide"; then
#   echo "tide is already installed."
# else
#   echo "Installing tide..."
#   fish -c "fisher install IlanCosman/tide@v5"
# fi

echo -e "\n<<< checking if starship is installed >>\n"
if ! command -v "starship" &> /dev/null; then
  echo "starship is not installed. Installing..."
  curl -sS https://starship.rs/install.sh | sh
else
  echo "starship is already installed."
fi

# Remove fish/conf.d folder
$(which rm) -rf $HOME/.config/fish/conf.d/
echo -e "\n<<< fish setup finished. >>>\n"

