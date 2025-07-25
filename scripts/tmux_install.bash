#!/usr/bin/env bash

# Color definitions
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m" # No Color

ech() {
    echo -e "$@"
}

ech -e "\n ${YELLOW} <<< Running $0 >>> ${NC} \n"

# Check if Tmux is installed
ech -e "\n ${YELLOW} <<< Checking if tmux is installed. >>> ${NC} \n"
if ! command -v "tmux" &> /dev/null; then
    ech "${RED} tmux is not installed. Installing... ${NC}"
    sudo apt install tmux -y
    
    ech "${GREEN} tmux installed successfully. ${NC} \n"
else
    ech "${GREEN} tmux is already installed. ${NC} \n"
fi

# Check if TMP is installed
ech -e "\n ${YELLOW} <<< Checking if TPM is installed. >>> ${NC} \n"
if [ -d ~/.tmux/plugins/tpm ]; then
    ech "${GREEN} TPM is already installed. ${NC} \n"
else
    ech "${RED} TPM is not installed. Installing... ${NC}"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ech "${GREEN} TPM installed successfully. ${NC} \n"
fi

# Check if tmuxifier is installed
ech -e "\n ${YELLOW} <<< Checking if tmuxifier is installed. >>> ${NC} \n"
if [ -d ~/.tmuxifier ]; then
    ech "${GREEN} tmuxifier is already installed. ${NC} \n"
else
    ech "${RED} tmuxifier is not installed. Installing... ${NC}"
    git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
    
    #define a marker for the block of text
    marker='# Tmuxifier initializer'
    
    # Add tmuxifier bin to PATH in .bashrc if it's not already there
    if ! grep -q "${marker}" ~/.bashrc; then
        ech -e "\n${marker}\nexport PATH=\$HOME/.tmuxifier/bin:\$PATH\"" >> ~/.bashrc
    ech -e '\neval "$(tmuxifier init -)"' >> ~/.bashrc
    ech -e "\n ${GREEN} tmuxifier bin was added to PATH in .bashrc ${NC}"
  else
    ech "${GREEN} tmuxifier bin is already in .bashrc ${NC}"
  fi

  # Add tmuxifier bin to PATH in config.fish if its not already there
  if ! grep -q "${marker}" ~/.config/fish/config.fish; then
        ech -e "\n${marker}\nset -gx TMUXIFIER \"\$HOME/.tmuxifier/" >> ~/.config/fish/config.gish
        ech -e "\nset  PATH \"\$TMUXIFIER/bin\" \$PATH\"" >> ~/.config/fish/config.fish
        ech -e "\n ${GREEN} tmuxifier bin was added to PATH in config.fish ${NC}"
    else
        ech "${GREEN} tmuxifier bin is already in config.fish ${NC}"
    fi
fi

ech -e "\n ${YELLOW} <<< tmux setup finished. >>> ${NC} \n"

