#!/usr/bin/env bash

# Color definitions
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m" # No Color

ech() {
    echo -e "$@"
}

ech"\n ${YELLOW} <<< Running $0 >>> ${NC} \n"

# Install Go documentation
ech -e "${YELLOW} Checking if go documentation is installed... ${NC}"

if ! command -v "godoc" &> /dev/null; then
    ech "${RED} go documentation is not installed. Installing... ${NC}"
    sudo apt install golang-golang-x-tools
    
    go install golang.org/x/tools/cmd/godoc@latest
    
    ech "${GREEN} go documentation installed successfully. ${NC} \n"
else
    ech "${GREEN} go documentation is already installed. ${NC}"
fi

ech "\n ${YELLOW} <<< Go documentation installment finished >>> ${NC} \n"