#!/usr/bin/env bash
# version-linker.sh

set -euo pipefail

if command -v btop >/dev/null 2>&1; then
    btop_raw=$(btop --version 2>/dev/null \
        | sed -r 's/\x1B(\[[0-9;]*[JKmsu]|\(B)//g' \
        | awk '/version:/ {print $NF}' )
    btop_version="${btop_raw:-unknown}"

    btop_versioned="btop_${btop_version}.conf"
    btop_target="$HOME/dotfiles/.config/btop/$btop_versioned"
    btop_link="$HOME/dotfiles/.config/btop/btop.conf"

    if [[ -f "$btop_target" ]]; then
        ln -srf "$btop_target" "$btop_link"
        echo "→ Linked btop config: $btop_versioned → btop.conf"
    else
        echo "  No config found for btop version → $btop_version"
        echo "  Expected: ~/dotfiles/.config/btop/$btop_versioned"
    fi
else
    echo "→ btop not installed — skipping"
fi

if command -v htop >/dev/null 2>&1; then
    htop_raw=$(htop --version 2>/dev/null | grep -o '[0-9].*$' | head -n1 | xargs)
    htop_version="${htop_raw:-unknown}"

    htop_versioned="htoprc_${htop_version}"
    htop_target="$HOME/dotfiles/.config/htop/$htop_versioned"
    htop_link="$HOME/dotfiles/.config/htop/htoprc"

    if [[ -f "$htop_target" ]]; then
        ln -srf "$htop_target" "$htop_link"
        echo "→ Linked htop config: $htop_versioned → htoprc"
    else
        echo "  No config found for htop version → $htop_version"
        echo "  Expected: ~/dotfiles/.config/htop/$htop_versioned"
    fi
else
    echo "→ htop not installed — skipping"
fi
