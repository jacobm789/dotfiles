#!/bin/bash

echo "Updating and upgrading system..."
sudo pacman -Syu --noconfirm

PACKAGES=(
    btop
    base-devel
    cmake
    curl
    fastfetch
    fail2ban
    fd
    gettext
    github-cli
    go
    htop
    lf
    ninja
    nmap
    npm
    ripgrep
    sshfs
    stow
    tealdeer
    tmux
    timeshift
    ufw
    unzip
    vim
    wget
    wl-clipboard
)

echo "Installing packages..."
sudo pacman -S --needed "${PACKAGES[@]}"

echo "Cleaning up..."
sudo pacman -Sc --noconfirm

echo "Setup complete!"
