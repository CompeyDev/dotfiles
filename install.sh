#!/bin/bash
set -e

git submodule init
git submodule update

declare -a deps=("zsh" "zsh-autosuggestions" "zsh-syntax-highlighting" "starship" "exa" "bat" "fastfetch")

echo ""
echo "#############################"
echo " Checking for dependencies..."
echo "#############################"

for dep in ${deps[@]}
do
    if ! which $dep 2>/dev/null; then
        echo "[!] Dependency $dep not found!"
        sudo pacman -Syy --noconfirm "$dep"
    else
        echo -e "\e[1A\e[K[*] FOUND: $dep"
    fi
done

echo ""
echo "Symlinking configs for user: ${whoami}"

find * -exec "ln -s -f {} $HOME/{}" \;

echo ""
echo "##### ALL DONE"
