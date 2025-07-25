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

ech "\n ${YELLOW} <<< Checking if Minikube is installed. >>> ${NC} \n"
if ! command -v minikube &> /dev/null
then
    ech "${RED} Minikube is not installed. Installing... ${NC}"
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm minikube-linux-amd64
    
    ech "${GREEN}Minikube installed successfully. ${NC} \n"
else
    ech "${GREEN} Minikube is already installed. ${NC}\n"
fi

ech "\n ${YELLOW} <<< Checking if Kubectl is installed. >>> ${NC} \n"
if ! command -v kubectl &> /dev/null
then
    ech "${RED} Kubectl is not installed. Installing... ${NC}"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    sudo rm kubectl
    
    ech "${GREEN} Kubectl installed successfully. ${NC} \n"
else
    ech "${GREEN} Kubectl is already installed. ${NC} \n"
fi

ech "\n ${YELLOW} <<< kubernetes setup finished. >>> ${NC} \n"
