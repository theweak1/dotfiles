#!/usr/bin/env bash
set -euo pipefail

# Color definitions
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m" # No Color

ech() {
    echo -e "$@"
}

ech "\n ${YELLOW} <<< Running $0 >>> ${NC} \n"

# Configuration
VAULT_REPO="https://github.com/theweak1/devops-journey.git"
VAULT_DIR="$HOME/Obsidian/devops/"

# Check if vault directory already exists
if [[ -d "$VAULT_DIR" ]]; then
    ech "${YELLOW} Vault already exists at $VAULT_DIR ${NC}"
    ech "${YELLOW} Do you want to update it? (y/N): ${NC}"
    read -r update_choice
    if [[ "$update_choice" =~ ^[Yy]$ ]]; then
        ech "Updating vault..."
        cd "$VAULT_DIR"
        git pull origin main || git pull origin master
        ech "${GREEN} Vault updated successfully! ${NC}"
    else
        ech "${YELLOW} Skipping vault update. ${NC}"
    fi
else
    ech "${YELLOW} Cloning vault from $VAULT_REPO ${NC}"
    git clone "$VAULT_REPO" "$VAULT_DIR"
    ech "${GREEN} Vault cloned successfully to $VAULT_DIR ${NC}"
fi

ech "\n ${YELLOW} <<< Vault setup finished! >>> ${NC} \n"
