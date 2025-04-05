export DOTFILES=~/dotfiles

[ -f "$DOTFILES/.bashrc.common" ] && source "$DOTFILES/.bashrc.common"

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
    Darwin)
        if [ -f "$DOTFILES/.bashrc.mac" ]; then
            source "$DOTFILES/.bashrc.mac"
            CONFIG_LOADED=1
        fi
        ;;
    Linux)
        if grep -qi microsoft /proc/version 2>/dev/null; then
            if [ -f "$DOTFILES/.bashrc.windows" ]; then
                source "$DOTFILES/.bashrc.windows"
                CONFIG_LOADED=1
            fi
        else
            DISTRO=$(detect_distro)
            case "$DISTRO" in
                debian)
                    if [ -f "$DOTFILES/.bashrc.debian" ]; then
                        source "$DOTFILES/.bashrc.debian"
                        CONFIG_LOADED=1
                    fi
                    ;;
                arch)
                    if [ -f "$DOTFILES/.bashrc.arch" ]; then
                        source "$DOTFILES/.bashrc.arch"
                        CONFIG_LOADED=1
                    fi
                    ;;
            esac
        fi
        ;;
esac

if [ "$CONFIG_LOADED" -eq 0 ] && [ -f ~/.bashrc.bak ]; then
    echo "[.bashrc] No matching config found. Falling back to ~/.bashrc.bak"
    source ~/.bashrc.bak
fi

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
