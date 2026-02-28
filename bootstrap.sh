#!/usr/bin/env bash

# Dotfiles Bootstrap Script
# This script sets up your dotfiles on a new device with a single command.
# 
# Usage:
#   curl -sL https://raw.githubusercontent.com/YOUR_USERNAME/dotfiles/main/bootstrap.sh | bash
#
# Or clone manually and run:
#   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
#   cd ~/.dotfiles && ./install
#
# Customize the DOTFILES_REPO variable below to point to your dotfiles repository.

set -e

# Color definitions
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

# Configuration - Change this to your dotfiles repository
# Default points to local ~/.dotfiles if running from within the directory
DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/theweak1/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

ech() {
    echo -e "$@"
}

ech "\n ${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
ech " ${BLUE}║           Dotfiles Bootstrap Installer                       ║${NC}"
ech " ${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}\n"

# Check if running in CI/automated mode (no interactive prompts)
if [ -n "$CI" ] || [ -n "$DOTFILES_CI_MODE" ]; then
    CI_MODE=true
    ech "${YELLOW}Running in CI mode - will use defaults without prompting${NC}\n"
else
    CI_MODE=false
fi

# Function to prompt for user input with a default
prompt_with_default() {
    local prompt="$1"
    local default="$2"
    local var_name="$3"
    
    if [ "$CI_MODE" = true ]; then
        eval "$var_name=$default"
        return
    fi
    
    read -p "$prompt [$default]: " value
    if [ -z "$value" ]; then
        eval "$var_name=$default"
    else
        eval "$var_name=$value"
    fi
}

# Check if git is installed
ech "${YELLOW}<<< Checking prerequisites >>>${NC}\n"

if ! command -v git &> /dev/null; then
    ech "${RED}git is not installed. Installing...${NC}"
    
    # Detect OS and install git
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y git
    elif command -v yum &> /dev/null; then
        sudo yum install -y git
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y git
    elif command -v brew &> /dev/null; then
        brew install git
    else
        ech "${RED}Cannot detect a supported package manager. Please install git manually.${NC}"
        exit 1
    fi
    
    ech "${GREEN}git installed successfully.${NC}\n"
else
    ech "${GREEN}git is already installed ($(git --version)).${NC}\n"
fi

# Check if running from within an existing dotfiles directory
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IS_DOTFILES_DIR=false

# Check if this looks like a dotfiles directory (has install script)
if [ -f "$CURRENT_DIR/install" ] && [ -f "$CURRENT_DIR/install.conf.yaml" ]; then
    IS_DOTFILES_DIR=true
    ech "${YELLOW}Detected running from within dotfiles directory.${NC}\n"
fi

# Clone or update dotfiles
ech "${YELLOW}<<< Setting up dotfiles >>>${NC}\n"

if [ "$IS_DOTFILES_DIR" = true ]; then
    # Running from within the dotfiles directory
    DOTFILES_DIR="$CURRENT_DIR"
    ech "${GREEN}Using existing dotfiles at: $DOTFILES_DIR${NC}\n"
elif [ -d "$DOTFILES_DIR/.git" ]; then
    # Dotfiles directory exists, update it
    ech "${YELLOW}Dotfiles already exist at $DOTFILES_DIR, updating...${NC}\n"
    cd "$DOTFILES_DIR"
    git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || true
    ech "${GREEN}Dotfiles updated.${NC}\n"
else
    # Clone the repository
    ech "${YELLOW}Cloning dotfiles from: $DOTFILES_REPO${NC}\n"
    
    # Check if user wants to specify a different repo
    if [ "$CI_MODE" = false ]; then
        echo ""
        ech "The installer will clone your dotfiles from:"
        ech "  ${GREEN}$DOTFILES_REPO${NC}"
        echo ""
        read -p "Press Enter to continue or type a different repo URL: " custom_repo
        
        if [ -n "$custom_repo" ]; then
            DOTFILES_REPO="$custom_repo"
        fi
    fi
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$DOTFILES_DIR")"
    
    # Clone the repo
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    cd "$DOTFILES_DIR"
    
    ech "${GREEN}Dotfiles cloned successfully.${NC}\n"
fi

# Initialize submodules
ech "${YELLOW}<<< Initializing git submodules (dotbot) >>>${NC}\n"
cd "$DOTFILES_DIR"
git submodule update --init --recursive 2>/dev/null || true

# Make scripts executable
chmod +x "$DOTFILES_DIR/install"
chmod +x "$DOTFILES_DIR/scripts"/*.bash
chmod +x "$DOTFILES_DIR/scripts"/**/*.bash 2>/dev/null || true

# Run the installation
ech "\n${YELLOW}<<< Starting dotfiles installation >>>${NC}"
ech "${YELLOW}This may take a while as it installs all your tools and configurations.${NC}\n"

# Check if we should run interactively or not
if [ "$CI_MODE" = true ]; then
    ./install --skip-asks
else
    ./install
fi

ech "\n${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
ech "${GREEN}║           Installation completed successfully!               ║${NC}"
ech "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
ech ""
ech "${YELLOW}Next steps:${NC}"
ech "  1. Restart your terminal or run: ${GREEN}exec \$SHELL${NC}"
ech "  2. If fish shell was installed, it will be your default shell"
ech "  3. Your dotfiles are installed and ready to use!"
ech ""
ech "${BLUE}Happy coding! 🚀${NC}\n"
