#!/usr/bin/env bash 

set -e


bold=$(tput bold)
normal=$(tput sgr0)

echo_text() {
    echo
    echo "========================================"
    echo "${bold}$1${normal}"
    echo "========================================"
}

install_apps(){
    if sudo pacman -S --noconfirm --needed $1 &> /dev/null; then
        printf "${bold}%-23s${normal} ✔\n" "$1"
    else
        printf "${bold}%-23s${normal} ❌\n" "$1"
    fi
}

main(){
    echo_text "Installing Applications"
    packages=("fish" "ghostty" "zed" "uv" "starship" "firefox" "neovim" "ttf-jetbrains-mono-nerd")
    for item in "${packages[@]}";
        do install_apps "$item"
    done

    echo_text "Placing dotfiles"
    python3 config_placer.py
}

main
