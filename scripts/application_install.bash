#!/usr/bin/env bash

# Color definitions
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

ech() {
    echo -e "$@"
}

ech "\n ${YELLOW} <<< Running $0 >>> ${NC} \n"

# Detect package manager
detect_package_manager() {
    if command -v apt-get &>/dev/null; then
        echo "apt"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v pacman &>/dev/null; then
        echo "pacman"
    elif command -v zypper &>/dev/null; then
        echo "zypper"
    elif command -v brew &>/dev/null; then
        echo "brew"
    else
        echo "unknown"
    fi
}

PM=$(detect_package_manager)
ech "${BLUE}Detected package manager: $PM${NC}\n"

#check if system is being run in WSL
if grep -qi microsoft /proc/version; then
    ech "${RED} System is running in WSL, applications cannot be installed. ${NC}"
    exit 0
fi

# Check if running in a desktop environment
if [[ -z "$XDG_CURRENT_DESKTOP" && -z "$DESKTOP_SESSION" && -z "$GNOME_DESKTOP_SESSION_ID" ]]; then
    ech "${RED} No desktop environment detected. Exiting. ${NC}"
    exit 0
fi

# Function to install Discord based on package manager
install_discord() {
    case $PM in
        apt)
            URL="https://dl.discordapp.net/apps/linux/0.0.42/discord-0.0.42.deb"
            wget -q -O discord.deb "$URL"
            sudo dpkg -i discord.deb || sudo apt install -f -y
            rm -f discord.deb
            ;;
        dnf)
            sudo dnf config-manager --add-repo https://negativo17.org/repos/discord.repo
            sudo dnf install -y discord
            ;;
        pacman)
            if command -v yay &>/dev/null; then
                yay -S discord
            fi
            ;;
        brew)
            brew install --cask discord
            ;;
        *)
            ech "${RED} Discord is not supported on this package manager.${NC}"
            ;;
    esac
}

# Function to install WhatsApp based on package manager
install_whatsapp() {
    case $PM in
        apt)
            # Try flatpak first (most reliable), then snap, then web app
            if command -v flatpak &>/dev/null; then
                flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>/dev/null
                flatpak install -y flathub io.github.mimbrero.WhatsAppDesktop 2>/dev/null && return 0
            fi
            if command -v snap &>/dev/null; then
                sudo snap install whatsapp-for-linux 2>/dev/null && return 0
            fi
            # Try web-based alternative
            ech "${YELLOW} Trying WhatsApp web-based installation...${NC}"
            ;;
        dnf)
            if command -v flatpak &>/dev/null; then
                flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>/dev/null
                flatpak install -y flathub io.github.mimbrero.WhatsAppDesktop 2>/dev/null && return 0
            fi
            if command -v snap &>/dev/null; then
                sudo snap install whatsapp-for-linux 2>/dev/null && return 0
            fi
            ;;
        pacman)
            if command -v yay &>/dev/null; then
                yay -S whatsapp-nativefier-bin
            fi
            ;;
        brew)
            brew install --cask whatsapp
            ;;
        *)
            ech "${RED} WhatsApp is not supported on this package manager.${NC}"
            ;;
    esac
}

# Function to install Brave browser based on package manager
install_brave() {
    case $PM in
        apt)
            sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
            echo "deb [arch=amd64 signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list >/dev/null
            sudo apt update -qq && sudo apt install -y brave-browser
            ;;
        dnf)
            sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            sudo dnf install -y brave-browser
            ;;
        pacman)
            if command -v yay &>/dev/null; then
                yay -S brave-bin
            fi
            ;;
        brew)
            brew install --cask brave-browser
            ;;
        *)
            ech "${RED} Brave browser is not supported on this package manager.${NC}"
            ;;
    esac
}

# Check if Discord is installed
ech "\n ${YELLOW} <<< Checking if Discord is installed. >>> ${NC} \n"
if ! grep -q "discord" /usr/share/applications/* 2>/dev/null && ! command -v discord &>/dev/null; then
    ech "${RED} Discord is not installed. Installing... ${NC}"
    install_discord
    if command -v discord &>/dev/null || grep -q "discord" /usr/share/applications/* 2>/dev/null; then
        ech "${GREEN} Discord installed successfully. ${NC}"
    else
        ech "${RED} Failed to install Discord. ${NC}"
    fi
else
    ech "${GREEN} Discord is already installed. ${NC}"
fi

# Check if WhatsApp is installed
ech "\n ${YELLOW} <<< Checking if WhatsApp is installed. >>> ${NC} \n"
if ! grep -q -i "whatsapp" /usr/share/applications/* 2>/dev/null && ! command -v whatsapps &>/dev/null; then
    ech "${RED} WhatsApp is not installed. Installing... ${NC}"
    install_whatsapp
    if grep -q -i "whatsapp" /usr/share/applications/* 2>/dev/null || command -v whatsapps &>/dev/null; then
        ech "${GREEN} WhatsApp installed successfully. ${NC}"
    else
        ech "${RED} Failed to install WhatsApp. ${NC}"
    fi
else
    ech "${GREEN} WhatsApp is already installed. ${NC}"
fi

# Check if Backdrop is already installed (installs to home directory, independent of package manager)
ech "\n ${YELLOW} <<< Checking if backdrop is installed. >>> ${NC} \n"
if ! command -v "backdrop" &>/dev/null; then
    ech "${RED} backdrop is not installed. Installing... ${NC}"
    BACKDROP_VERSION=$(curl -s "https://api.github.com/repos/JanMichaelSE/backdrop/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    
    if wget -q -O backdrop.tar.gz "https://github.com/JanMichaelSE/backdrop/releases/download/v${BACKDROP_VERSION}/backdrop-gnome-desktop-v${BACKDROP_VERSION}.linux-amd64.tar.gz"; then
        if tar -xf backdrop.tar.gz; then
            mkdir -p $HOME/.backdrop/bin
            mv backdrop $HOME/.backdrop/bin
            rm -f backdrop.tar.gz
            ech "${GREEN} Backdrop installed successfully. ${NC}"
        else
            ech "${RED} Failed to extract Backdrop. ${NC}"
        fi
    else
        ech "${RED} Failed to download Backdrop. ${NC}"
    fi
else
    ech "${GREEN} Backdrop is already installed. ${NC}"
fi

# Check if Brave browser is installed
ech "\n ${YELLOW} <<< Checking if Brave browser is installed. >>> ${NC} \n"
if ! command -v "brave-browser" &>/dev/null && ! grep -q "brave" /usr/share/applications/* 2>/dev/null; then
    ech "${RED} Brave browser is not installed. Installing... ${NC}"
    install_brave
    if command -v brave-browser &>/dev/null || grep -q "brave" /usr/share/applications/* 2>/dev/null; then
        ech "${GREEN} Brave browser installed successfully. ${NC}"
    else
        ech "${RED} Failed to install Brave browser. ${NC}"
    fi
else
    ech "${GREEN} Brave browser is already installed. ${NC}"
fi

ech "\n ${YELLOW} <<< Application setup finished. >>> ${NC} \n"
