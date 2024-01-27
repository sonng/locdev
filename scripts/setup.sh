#!/bin/bash
set -x

# Install dependencies
sudo dnf update -y
sudo dnf upgrade -y

sudo dnf install -y \
    zsh

# Setup sudo to allow no-password
sudo groupadd -r dev
sudo useradd -m -s /bin/zsh dev
sudo usermod -a -G dev dev
sudo cp /etc/sudoers /etc/sudoers.orig
echo "dev ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/dev

# Install SSH key
sudo mkdir -p /home/dev/.ssh
sudo chmod 700 /home/dev/.ssh
sudo cp /tmp/id_ed25519.pub /home/dev/.ssh/authorized_keys
sudo chown -R dev /home/dev/.ssh
sudo usermod --shell /bin/zsh dev

