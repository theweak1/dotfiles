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

# Check if bat is installed
ech "\n ${YELLOW} <<< Checking if bat is installed. >>> ${NC} \n"
if ! command -v "bat" &>/dev/null; then
    ech "${RED}bat is not installed. Installing...${NC}"
    BAT_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    
    # Download the correct architecture (amd64, not musl)
    wget -O bat_amd64.deb "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb"
    
    sudo dpkg -i bat_amd64.deb || sudo apt install -f -y
    rm bat_amd64.deb
    
    ech "${GREEN} bat installed successfully. ${NC} \n"
else
    # Get the latest version from GitHub
    BAT_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    
    # Get the version installed on the machine
    INSTALLED_VERSION=$(bat --version | awk '{print $2}')
    
    # Compare the two versions
    if [ "$BAT_VERSION" == "$INSTALLED_VERSION" ]; then
        ech "${GREEN} You have the latest version of bat installed. ${NC}"
    else
        ech "${YELLOW} A newer version of bat is available. Latest version: $BAT_VERSION, Installed version: $INSTALLED_VERSION ${NC}"
        
        # Ask the user if they want to update with "yes" as the default option
        read -p "Do you want to update to the latest version? (Y/n) " choice
        
        case "$choice" in
            n | N)
                ech "Update cancelled."
            ;;
            y | Y | "")
                # Update the software
                ech "Updating to the latest version..."
                wget -O bat_amd64.deb "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb"
                
                sudo dpkg -i bat_amd64.deb || sudo apt install -f -y
                rm bat_amd64.deb
                
                ech "${GREEN} bat updated successfully. ${NC} \n"
            ;;
            *)
                ech "Invalid choice."
            ;;
        esac
    fi
fi

# Check if pip3 is installed
ech "\n ${YELLOW} <<< Checking if pip3 is installed. >>> ${NC} \n"
if ! command -v "pip3" &>/dev/null; then
    ech "${RED} pip3 is not installed. Installing... ${NC}"
    sudo apt install python3-pip -y
    
    ech "${GREEN} pip3 installed successfully. ${NC} \n"
else
    ech "${GREEN} pip3 is already installed. ${NC} \n"
fi

# Check if eza/exa is already installed
# Note: exa is deprecated, eza is the maintained fork
ech "\n ${YELLOW} <<< Checking if eza/exa is installed. >>> ${NC} \n"
if command -v "eza" &>/dev/null; then
    ech "${GREEN} eza is already installed. ${NC}"
elif command -v "exa" &>/dev/null; then
    ech "${YELLOW} exa is installed but deprecated. Consider switching to eza. ${NC}"
else
    ech "${RED} eza/exa is not installed. Attempting to install with apt... ${NC}"
    
    # Try to install eza (modern exa replacement) using apt
    if sudo apt install eza -y; then
        ech "${GREEN} eza is installed via apt. ${NC}"
    else
        ech "${RED} eza cannot be installed with apt. Proceeding with Cargo installation... ${NC}"
        
        # Check if Rust and Cargo are installed
        if ! command -v "cargo" &>/dev/null; then
            ech "Installing Rust and Cargo..."
            sudo apt update
            sudo apt install rustc cargo -y
        fi
        
        # Install eza using Cargo (preferred over deprecated exa)
        ech "Installing eza..."
        cargo install eza
        
        ech "${GREEN} eza installed successfully via Cargo. ${NC}"
    fi
fi

# Check if tree is installed
ech "\n ${YELLOW} <<< Checking if tree is installed. >>> ${NC} \n"
if ! command -v "tree" &>/dev/null; then
    ech "${RED} tree is not installed. Installing... ${NC}"
    sudo apt install tree -y
    
    ech "${GREEN} tree installed successfully. ${NC} \n"
else
    ech "${GREEN} tree is already installed. ${NC} \n"
fi

# Check if fzf is installed
ech "\n ${YELLOW} <<< Checking if fzf is installed. >>> ${NC} \n"
if ! command -v "fzf" &> /dev/null; then
    ech "fzf is not installed. Installing..."
    sudo apt install fzf -y
    
    ech "${GREEN} fzf installed successfully. ${NC} \n"
else
    ech "${GREEN} fzf is already installed. ${NC} \n"
fi

# Check if go is installed
# NOTE: Go configuration is handled in config/fish/config.fish and will be symlinked
ech "\n ${YELLOW} <<< Checking if go is installed. >>> ${NC} \n"
if ! command -v "go" &> /dev/null; then
    ech "${RED} go is not installed. Installing... ${NC}"
    
    go_version="1.22.7"  # Update this to the latest version
    download_url="https://golang.org/dl/go${go_version}.linux-amd64.tar.gz"
    
    # Download and install Go
    wget $download_url -O /tmp/go.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz
    rm /tmp/go.tar.gz
    
    ech "${GREEN} go installed successfully. ${NC} \n"
    ech "${YELLOW}Note: Go PATH configuration is already in your dotfiles config.fish${NC}"
else
    ech "${GREEN} go is already installed. ${NC} \n"
fi

# Check if lazydocker is installed
ech "\n ${YELLOW} <<< Checking if lazydocker is installed. >>> ${NC} \n"
if ! command -v "lazydocker" &>/dev/null && [ ! -f "/usr/local/bin/lazydocker" ]; then
    ech "${RED} lazydocker is not installed. Installing... ${NC}"
    sudo curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    
    ech "${GREEN} lazydocker installed successfully. ${NC} \n"
else
    ech "${GREEN}lazydocker is already installed. ${NC} \n"
fi
ech "\n ${YELLOW} <<< software install finished. >>> ${NC} \n"
