#!/bin/bash
set -e

echo "Updating package lists..."
sudo apt-get update

echo "Installing prerequisites..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg \
    lsb-release

echo "Installing Git and Vim..."
sudo apt-get install -y git vim

echo "Installing VSCode..."

# Import Microsoft GPG key
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
rm microsoft.gpg

# Add VSCode repo for Debian (bullseye)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

sudo apt-get update
sudo apt-get install -y code

echo "Installing Docker..."

# Remove old Docker versions if present (won't fail if none)
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

# Add Docker's official GPG key and repo for Debian
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "Installing Docker Compose..."

# Get latest Docker Compose version tag from GitHub API
DOCKER_COMPOSE_VERSION=$(curl -fsSL https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Installation complete!"

echo "Versions installed:"
git --version
vim --version | head -n1
# code --version
docker --version
docker-compose --version

echo "Creating volume dirs..."

echo "Volumes successfully created"

sudo sed -i 's/^127\.0\.0\.1\s\+localhost$/127.0.0.1       khadj-me.42.fr/' /etc/hosts

echo "Changed localhost to khadj-me.42.fr in /etc/hosts file"