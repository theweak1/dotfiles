#!/bin/bash

echo -e "\n <<< Running $0 >>>\n"

echo -e "\n<<< Checking if Minikube is installed. >>>\n"
if ! command -v minikube &> /dev/null
then
  echo "Minikube is not installed. Installing..."
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
  rm minikube-linux-amd64
else
    echo "Minikube is already installed."
fi

echo -e "\n<<< Checking if Kubectl is installed. >>>\n"
if ! command -v kubectl &> /dev/null
then
  echo "Kubectl is not installed. Installing..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  sudo rm kubectl
else
    echo "Kubectl is already installed."
fi

exit 0
