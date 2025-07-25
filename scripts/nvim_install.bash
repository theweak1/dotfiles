#!/usr/bin/env bash
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
glibc_version=$(ldd --version | head -n1 | grep -Po '\d+\.\d+')
ech "${YELLOW} Detected GLIBC version: $glibc_version ${NC}"

# Function to download and install nvim
install_nvim() {
    ech "${YELLOW} Installing nvim... ${NC}"
    sudo apt update
    sudo apt install -y libfuse2 wget jq
    
    if [[ "$ARCH" != "x86_64" && "$ARCH" != "aarch64" ]]; then
        ech "${RED} Unsupported architecture: $ARCH ${NC}"
        exit 1
    fi
    
    # Determine source based on GLIBC version
    if [[ $(ech "$glibc_version < 2.32" | bc -l) -eq 1 ]]; then
        ech "${YELLOW} Older glibc detected ($glibc_version). Using fallback Neovim build... ${NC}"
        download_url="https://github.com/neovim/neovim-releases/releases/latest/download/nvim.appimage"
    else
        # Fetch latest release JSON
        release_json=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest)
        
        case "$ARCH" in
            x86_64)
                file="nvim-linux-x86_64.appimage"
            ;;
            aarch64)
                file="nvim-linux-arm64.appimage"
            ;;
        esac
        
        # Find the correct download URL
        download_url=$(ech "$release_json" | jq -r --arg file "$file" '.assets[] | select(.name == $file) | .browser_download_url')
        
        if [[ -z "$download_url" ]]; then
            ech "${RED} Could not find a matching download for your architecture ($ARCH). ${NC}"
            exit 1
        fi
    fi
    
    ech "Downloading Neovim from: $download_url"
    wget "$download_url" -O nvim.appimage
    chmod +x nvim.appimage
    sudo mv nvim.appimage /usr/bin/nvim
}

# Check if nvim is installed
ech "\n ${YELLOW} Checking if nvim is installed. ${NC} \n"
if command -v "nvim" &> /dev/null; then
    ech "${GREEN} nvim is already installed. ${NC}"
    
    installed_version=$(nvim --version | head -n 1 | grep -Po '\d+\.\d+\.\d+')
    latest_version=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.tag_name' | sed 's/^v//')
    
    ech "Installed version: $installed_version"
    ech "Latest stable version: $latest_version"
    
    if [ "$installed_version" != "$latest_version" ]; then
        read -p "A newer version of nvim is available. Update? (y/N): " update_choice
        if [[ "$update_choice" =~ ^[Yy]$ ]]; then
            install_nvim
        fi
    fi
else
    install_nvim
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
    
    DOWNLOAD_DIR="$HOME/Downloads"
    mkdir -p "$DOWNLOAD_DIR"
    wget -P "$DOWNLOAD_DIR" "$FONT_URL"
    unzip -o "$DOWNLOAD_DIR/$FONT_ZIP" -d "$FONT_DIR"
    
    fc-cache -f -v
    ech "${GREEN} Font "$FONT_NAME" installed successfully. ${NC}"
fi

ech "\n ${YELLOW} <<< nvim setup finished successfully! >>> ${NC} \n"

