#!/usr/bin/env bash
set -euo pipefail

FONT_NAME="CaskaydiaCove NF"
FONT_ZIP="CascadiaCode.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/$FONT_ZIP"

# Color definitions
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m" # No Color

ech() {
    echo -e "$@"
}

ech "\n ${YELLOW} <<< Running $0 >>> ${NC} \n"

ARCH=$(uname -m)
ech "${YELLOW} Detected architecture: $ARCH ${NC}"

# Detect GLIBC version
glibc_version=$(ldd --version 2>&1 | head -n1 | sed -n 's/.*\([0-9]\.[0-9][0-9]\).*/\1/p' | head -n1)
ech "${YELLOW} Detected GLIBC version: $glibc_version ${NC}"

# Function to download and install nvim
install_nvim() {
    ech "${YELLOW} Installing nvim... ${NC}"
    
    # Check if we can run sudo without password, if not warn user
    if ! sudo -n true 2>/dev/null; then
        ech "${YELLOW} sudo may require password. If script hangs, press Ctrl+C and run manually. ${NC}"
    fi
    
    if ! sudo apt update 2>&1; then
        ech "${RED} Failed to update apt. Please ensure you have sudo access and try running manually. ${NC}"
        exit 1
    fi
    
    if ! sudo apt install -y libfuse2 wget jq 2>&1; then
        ech "${RED} Failed to install dependencies. Please ensure you have sudo access and try running manually. ${NC}"
        exit 1
    fi
    
    if [[ "$ARCH" != "x86_64" && "$ARCH" != "aarch64" ]]; then
        ech "${RED} Unsupported architecture: $ARCH ${NC}"
        exit 1
    fi
    
    # Determine source based on GLIBC version
    glibc_major=$(echo "$glibc_version" | cut -d. -f1)
    glibc_minor=$(echo "$glibc_version" | cut -d. -f2)
    if [[ $glibc_major -lt 2 ]] || [[ $glibc_major -eq 2 && $glibc_minor -lt 32 ]]; then
        ech "${YELLOW} Older glibc detected ($glibc_version). Using fallback Neovim build... ${NC}"
        download_url="https://github.com/neovim/neovim-releases/releases/latest/download/nvim.appimage"
    else
        # Fetch latest release JSON (filter out control characters for jq)
        release_json=$(curl -sL https://api.github.com/repos/neovim/neovim/releases/latest | tr -d '\000-\037')
        
        if [[ -z "$release_json" ]]; then
            ech "${RED} Failed to fetch release information from GitHub. ${NC}"
            exit 1
        fi
        
        case "$ARCH" in
            x86_64)
                file="nvim-linux-x86_64.appimage"
            ;;
            aarch64)
                file="nvim-linux-arm64.appimage"
            ;;
        esac
        
        # Find the correct download URL
        download_url=$(echo "$release_json" | jq -r --arg file "$file" '.assets[] | select(.name == $file) | .browser_download_url')
        
        if [[ -z "$download_url" ]]; then
            ech "${RED} Could not find a matching download for your architecture ($ARCH). ${NC}"
            exit 1
        fi
    fi
    
    ech "Downloading Neovim from: $download_url"
    wget "$download_url" -O nvim.appimage || { ech "${RED} Failed to download Neovim. ${NC}"; exit 1; }
    chmod +x nvim.appimage
    
    # Try to run AppImage directly (works if FUSE is available)
    if ./nvim.appimage --version &> /dev/null; then
        ech "${GREEN} AppImage runs with FUSE. Installing directly... ${NC}"
        sudo mv nvim.appimage /usr/bin/nvim
    else
        # Extract AppImage if FUSE is not available
        ech "${YELLOW} FUSE not available. Extracting AppImage... ${NC}"
        ./nvim.appimage --appimage-extract &> /dev/null
        sudo mv squashfs-root /opt/nvim
        sudo ln -sf /opt/nvim/usr/bin/nvim /usr/bin/nvim
    fi
}

# Check if nvim is installed
ech "\n ${YELLOW} Checking if nvim is installed. ${NC} \n"
if command -v "nvim" &> /dev/null; then
    ech "${GREEN} nvim is already installed. ${NC}"
    
    installed_version=$(nvim --version | head -n 1 | grep -Po '\d+\.\d+\.\d+' | head -n1)
    latest_version=$(curl -sL https://api.github.com/repos/neovim/neovim/releases/latest | tr -d '\000-\037' | jq -r '.tag_name' 2>/dev/null | sed 's/^v//')
    
    ech "Installed version: $installed_version"
    ech "Latest stable version: $latest_version"
    
    if [ "$installed_version" != "$latest_version" ]; then
        read -p "A newer version of nvim is available. Update? (y/N): " update_choice
        if [[ "$update_choice" =~ ^[Yy]$ ]]; then
            install_nvim
        fi
    fi
else
    ech "${YELLOW} nvim is not installed. Install now? (y/N): ${NC}"
    read -r install_choice
    if [[ "$install_choice" =~ ^[Yy]$ ]]; then
        install_nvim
    else
        ech "${YELLOW} Skipping nvim installation. ${NC}"
    fi
fi

# Install dependencies
ech "\n ${YELLOW} Checking if dependencies are installed. ${NC} \n"
if ! command -v "clang" &> /dev/null || ! command -v "unzip" &> /dev/null; then
    ech "${YELLOW} Installing missing dependencies... ${NC}"
    sudo apt install clang unzip -y
fi

# Install font
ech "\n ${YELLOW} Checking if the font "$FONT_NAME" is installed. ${NC} \n"
if fc-list | grep -i "$FONT_NAME" &> /dev/null; then
    ech "${GREEN} Font "$FONT_NAME" is already installed. ${NC}"
else
    ech "${RED} Font "$FONT_NAME" is not installed. Installing... ${NC}"
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    
    TEMP_DIR=$(mktemp -d)
    wget -P "$TEMP_DIR" "$FONT_URL" || { ech "${RED} Failed to download font. ${NC}"; rm -rf "$TEMP_DIR"; exit 1; }
    unzip -o "$TEMP_DIR/$FONT_ZIP" -d "$FONT_DIR"
    rm -rf "$TEMP_DIR"
    
    fc-cache -f -v
    ech "${GREEN} Font "$FONT_NAME" installed successfully. ${NC}"
fi

ech "\n ${YELLOW} <<< nvim setup finished successfully! >>> ${NC} \n"

