#!/usr/bin/env bash

# Color definitions
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m" # No Color

ech() {
    echo -e "$@"
}

ech "\n ${YELLOW} <<< Running $0 >>> ${NC} \n"

# Check if fish is installed
ech "\n ${YELLOW} <<< Checking if fish is installed >>> ${NC} \n"
if ! command -v "fish" &> /dev/null; then
    ech "${RED} fish is not installed. Installing... ${NC}"
    sudo apt update
    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt update
    sudo apt-get install fish -y
    ech "Please enter sudo password to change default shell to fish"
    chsh -s /usr/bin/fish
    
    ech "${GREEN} fish installed successfully. ${NC} \n"
else
    ech "${GREEN} fish is already installed. ${NC} \n"
fi

ech "\n ${YELLOW} <<< checking if fisher is installed >>> ${NC} \n"
if ! fish -c "type fisher" &> /dev/null; then
    ech "${RED} fisher is not installed. Installing fisher... ${NC}"
    fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
    ech "${GREEN} fisher installed successfully. ${NC} \n"
else
    ech "${GREEN} fisher is already installed. ${NC} \n"
fi

ech "\n ${YELLOW} <<< checking if starship is installed >> ${NC} \n"
if ! command -v "starship" &> /dev/null; then
    ech "${RED} starship is not installed. Installing... ${NC}"
    curl -sS https://starship.rs/install.sh | sh
    
    ech "${GREEN} starship installed successfully. ${NC} \n"
else
    ech "${GREEN} starship is already installed. ${NC} \n"
fi

# Remove fish/conf.d folder
$(which rm) -rf $HOME/.config/fish/conf.d/

ech "\n ${YELLOW} <<< fish setup finished. >>> ${NC} \n"