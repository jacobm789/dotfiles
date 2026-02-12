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
    fzf
    gettext
    ghostty
    github-cli
    go
    keyd
    htop
    kitty
    lf
    neovim
    ninja
    nmap
    npm
    openssh
    rsyce
    ripgrep
    sl
    sshfs
    stow
    tealdeer
    tmux
    timeshift
    ufw
    unzip
    wget
    wl-clipboard
    zoxide
)

echo "Installing packages..."
sudo pacman -S --needed "${PACKAGES[@]}"

echo "Cleaning up..."
sudo pacman -Sc --noconfirm

echo "Setup complete!"
