#!/bin/bash

mkdir -p ~/dotfiles/.config/btop
mkdir -p ~/dotfiles/.config/htop

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

get_version_id() {
    . /etc/os-release
        echo "$VERSION_ID"
}

case "$(uname -s)" in
    Linux)
        DISTRO=$(detect_distro)
        case "$DISTRO" in
            arch)
                ln -srf ~/dotfiles/.config/btop/btop_arch.conf ~/dotfiles/.config/btop/btop.conf
                ln -srf ~/dotfiles/.config/htop/htoprc_arch ~/dotfiles/.config/htop/htoprc
            ;;
            debian)
                DEBIAN_VERSION=$(get_version_id)
                case "$DEBIAN_VERSION" in
                    12)
                        ln -srf ~/dotfiles/.config/btop/btop_debian_12.conf ~/dotfiles/.config/btop/btop.conf
                        ln -srf ~/dotfiles/.config/htop/htoprc_debian_12 ~/dotfiles/.config/htop/htoprc
                    ;;
                    13)
                        ln -srf ~/dotfiles/.config/btop/btop_debian_13.conf ~/dotfiles/.config/btop/btop.conf
                        ln -srf ~/dotfiles/.config/htop/htoprc_debian_13 ~/dotfiles/.config/htop/htoprc
                    ;;
                esac
            ;;
            fedora)
                FEDORA_VERSION=$(get_version_id)
                case "$FEDORA_VERSION" in
                    43)
                        ln -srf ~/dotfiles/.config/btop/btop_fedora_43.conf ~/dotfiles/.config/btop/btop.conf
                        ln -srf ~/dotfiles/.config/htop/htoprc_fedora_43 ~/dotfiles/.config/htop/htoprc
                    ;;
                esac
            ;;
        esac
    ;;
    Darwin)
        ln -srf ~/dotfiles/.config/btop/btop_mac.conf ~/dotfiles/.config/btop/btop.conf
        ln -srf ~/dotfiles/.config/htop/htoprc_mac ~/dotfiles/.config/htop/htoprc
    ;;
esac
