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

# Check if lazygit is installed is installed
ech "\n ${YELLOW} <<< Checking if lazygit is installed. >>> ${NC} \n"
if ! command -v "lazygit" &> /dev/null && [ ! -f "/usr/local/bin/lazygit" ]; then
    ech "${RED} lazygit is not installed. Installing... ${NC}"
    
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    
    rm lazygit.tar.gz lazygit
    
    ech "${GREEN} lazygit installed successfully. ${NC} \n"
else
    ech "${GREEN} lazygit is already installed.${NC}"
fi

# Check if delta is installed is installed
ech "\n ${YELLOW} <<< Checking if delta is installed. >>> ${NC} \n"

# Check if delta is already installed
if ! command -v "delta" &> /dev/null && [ ! -f "/usr/bin/delta" ]; then
    ech "${RED} delta not found. Installing... ${NC}"
    
    # Fetch the URL of the latest .deb release from GitHub
    DELTA_DEB_URL=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep "browser_download_url.*amd64.deb" | head -n 1 | cut -d '"' -f 4)
    
    # Download the .deb package
    wget "$DELTA_DEB_URL" -O delta.deb
    
    # Install the downloaded package
    sudo dpkg -i delta.deb
    
    # Fix any potential missing dependencies
    sudo apt-get update
    sudo apt-get --fix-broken install
    
    # Clean up
    rm delta.deb
    
    ech "${GREEN} delta installed successfully. ${NC} \n"
else
    ech "${GREEN} delta is already installed. ${NC} \n"
fi

# Check and append the configuration to lazygit's config file
CONFIG_PATH="$HOME/.config/lazygit/config.yml"
CONFIG_STRING="git:
paging:
colorArg: always
pager: delta --dark --paging=never"

# Convert the multi-line string into a single line
SINGLE_LINE_CONFIG_STRING=$(ech "$CONFIG_STRING" | tr '\n' ' ')

# Convert the file content into a single line and check for the presence of the string
if ! tr '\n' ' ' < "$CONFIG_PATH" | grep -qF "$SINGLE_LINE_CONFIG_STRING"; then
    mkdir -p "$HOME/.config/lazygit/"
    ech "$CONFIG_STRING" >> "$CONFIG_PATH"
    ech "${YELLOW} Configuration added to $CONFIG_PATH. ${NC}"
else
    ech "${YELLOW}Configuration already exists in $CONFIG_PATH. ${NC}"
fi

ech "\n ${YELLOW} <<< git setup finished. >>> ${NC} \n"
