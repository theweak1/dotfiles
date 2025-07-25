#!/bin/bash

# Color definitions
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m" # No Color

ech() {
    echo -e "$@"
}

ech "\n ${YELLOW} <<< Running $0 >>> ${NC} \n"

# Function to install Docker
install_docker() {
    # Update the apt package list
    sudo apt-get update -y
    
    # Install Docker's package dependencies
    sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
    # Download and add Docker's official public PGP key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    
    # Set up the stable Docker repository
    ech \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Update the apt package list (for the new apt repo)
    sudo apt-get update -y
    
    # Install Docker
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    
    # Allow your user to access the Docker CLI without needing root access
    # Note: Might need to restart system after installation for this to take affect.
    sudo usermod -aG docker $USER
}

# Function to install Docker Compose
install_docker_compose() {
    # Download the current stable release of Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    
    # Apply executable permissions to the binary
    sudo chmod +x /usr/local/bin/docker-compose
}

# Function to install Docker Machine
install_docker_machine() {
    # Download the Docker Machine binary
    base=https://github.com/docker/machine/releases/latest/download &&
    sudo curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
    sudo mv /tmp/docker-machine /usr/local/bin/docker-machine &&
    chmod +x /usr/local/bin/docker-machine
}

# Check if Docker is installed, if not, install Docker, Docker Compose, and Docker Machine
if ! command -v docker &> /dev/null
then
    ech "${RED} Docker is not installed. Installing Docker, Docker Compose, and Docker Machine... ${NC}"
    install_docker
    install_docker_compose
    install_docker_machine
    
    ech "${GREEN} Docker, Docker Compose, and Docker Machine installed. ${NC}"
else
    ech "${GREEN} Docker is already installed. ${NC}"
fi

ech "\n ${YELLOW} <<< Docker setup finished. >>> ${NC} \n"