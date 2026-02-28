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

ARCH=$(uname -m)
OBSIDIAN_DIR="$HOME/.local/bin"

# Check if running in a desktop environment
if [[ -z "$XDG_CURRENT_DESKTOP" && -z "$DESKTOP_SESSION" && -z "$GNOME_DESKTOP_SESSION_ID" ]]; then
    ech "${RED} No desktop environment detected. Exiting. ${NC}"
    exit 0
fi

# Check if Obsidian is already installed
if command -v obsidian &> /dev/null; then
    ech "${GREEN} Obsidian is already installed. ${NC}"
    ech "${YELLOW} To update, please remove the current version and reinstall. ${NC}"
else
    ech "${YELLOW} Installing Obsidian... ${NC}"
    
    # Create the bin directory if it doesn't exist
    mkdir -p "$OBSIDIAN_DIR"
    
    # Determine the download URL based on architecture
    case "$ARCH" in
        x86_64)
            download_url="https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.7/Obsidian-1.6.7.AppImage"
            filename="Obsidian-1.6.7.AppImage"
            ;;
        aarch64)
            download_url="https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.7/Obsidian-1.6.7-linux-arm64.AppImage"
            filename="Obsidian-1.6.7-linux-arm64.AppImage"
            ;;
        *)
            ech "${RED} Unsupported architecture: $ARCH ${NC}"
            exit 1
            ;;
    esac
    
    ech "Downloading Obsidian from: $download_url"
    
    # Download Obsidian
    if wget "$download_url" -O "$OBSIDIAN_DIR/$filename"; then
        chmod +x "$OBSIDIAN_DIR/$filename"
        
        # Create symlink for easy access
        sudo ln -sf "$OBSIDIAN_DIR/$filename" /usr/bin/obsidian
        
        # Create .desktop file for desktop database
        mkdir -p "$HOME/.local/share/applications"
        cat > "$HOME/.local/share/applications/obsidian.desktop" << EOF
[Desktop Entry]
Name=Obsidian
Comment=Obsidian
Exec=$OBSIDIAN_DIR/$filename
Icon=obsidian
Terminal=false
Type=Application
Categories=Office;TextEditor;
EOF
        
        # Update desktop database
        if command -v update-desktop-database &> /dev/null; then
            update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
        fi
        
        ech "${GREEN} Obsidian installed successfully! ${NC}"
        ech "You can run it by typing 'obsidian' or finding it in your applications menu."
    else
        ech "${RED} Failed to download Obsidian. ${NC}"
        exit 1
    fi
fi

# Ask if user wants to download vault
ech "${YELLOW} Would you like to download your Obsidian vault? (y/N): ${NC}"
read -r vault_choice
if [[ "$vault_choice" =~ ^[Yy]$ ]]; then
    if [[ -f "$(dirname "$0")/obsidian_related/get_vault.bash" ]]; then
        "$(dirname "$0")/obsidian_related/get_vault.bash"
    else
        ech "${RED} Vault download script not found. ${NC}"
    fi
fi

ech "\n ${YELLOW} <<< Obsidian setup finished successfully! >>> ${NC} \n"
