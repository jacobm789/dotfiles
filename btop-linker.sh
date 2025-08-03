#!/bin/bash

mkdir -p ~/dotfiles/.config/btop

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

case "$(uname -s)" in
    Linux)
        DISTRO=$(detect_distro)
        case "$DISTRO" in
            debian)
                ln -srf ~/dotfiles/debian/btop.conf ~/dotfiles/.config/btop/
                ;;
            arch)
                ln -srf ~/dotfiles/arch/btop.conf ~/dotfiles/.config/btop/
                ;;
        esac
        ;;
    Darwin)
        ln -srf ~/dotfiles/mac/btop.conf ~/dotfiles/.config/btop/
        ;;
esac
