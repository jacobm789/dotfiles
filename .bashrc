export DOTFILES=~/dotfiles

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

CONFIG_LOADED=0

case "$(uname -s)" in
    Linux)
        DISTRO=$(detect_distro)
        case "$DISTRO" in
            debian)
                source "$DOTFILES/.bashrc.debian"
                CONFIG_LOADED=1
                ;;
            arch)
                source "$DOTFILES/.bashrc.arch"
                CONFIG_LOADED=1
                ;;
        esac
        ;;
    Darwin)
        source "$DOTFILES/.bashrc.mac"
        CONFIG_LOADED=1
        ;;
esac

if [ "$CONFIG_LOADED" -eq 0 ] && [ -f ~/.bashrc.bak ]; then
    echo "[.bashrc] No matching config found. Falling back to ~/.bashrc.bak"
    source ~/.bashrc.bak
fi

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

bind 'set completion-ignore-case on'
