#!/usr/bin/env bash

git submodule init
git submodule update

declare -a deps=("zsh" "zsh-autosuggestions" "zsh-syntax-highlighting" "starship" "exa" "bat" "fastfetch" "stow")

echo ""
echo "#############################"
echo " Checking for dependencies..."
echo "#############################"

for dep in ${deps[@]}
do
    if ! which $dep 2>/dev/null; then
        echo "[!] Dependency $dep not found!"
        pacman -Syy "$dep"
    else
        echo -e "\e[1A\e[K[*] FOUND: $dep"
    fi
done

echo ""
echo "Stowing apps for user: ${whoami}"

find * -maxdepth 1 -exec "stow -v -R -t $HOME {}" \;

echo ""
echo "##### ALL DONE"
