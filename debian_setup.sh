#!/bin/bash

echo "Updating and upgrading system..."
sudo apt update -y && sudo apt full-upgrade -y

PACKAGES=(
    curl
    wget
    git
    gh
    vim
    htop
    btop
    ranger
    neofetch
    fastfetch
    tmux
    nmap
    sshfs
    tealdeer
    timeshift
    ufw
    fail2ban
)

echo "Installing packages..."
AVAILABLE_PACKAGES=()
for package in "${PACKAGES[@]}"; do
    if apt-cache show "$package" &>/dev/null; then
        AVAILABLE_PACKAGES+=("$package")
    else
        echo "Skipping unavailable package: $package"
    fi
done

if [ ${#AVAILABLE_PACKAGES[@]} -gt 0 ]; then
    sudo apt install -y "${AVAILABLE_PACKAGES[@]}"
else
    echo "No valid packages to install."
fi

echo "Cleaning up..."
sudo apt autopurge -y && sudo apt clean

echo "Setup complete!"
