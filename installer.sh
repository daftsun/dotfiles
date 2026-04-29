#!/bin/bash

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
    packages=("fish" "ghostty" "zed" "uv" "starship" "firefox" "neovim" "git" "ttf-jetbrains-mono-nerd")
    for item in "${packages[@]}";
        do install_apps "$item"
    done

    echo_text "Setting up configurations"
    cd $HOME
    [ ! -d "Github" ] && mkdir "Github"
    echo "Created Github Directory"
    cd ./Github/
    [ ! -d "dotfiles" ] && git clone https://github.com/aditya27gupta/dotfiles.git
    echo "Pulled Dotfile Repository"

    echo_text "Placing dotfiles"
    python3 ./dotfiles/config_placer.py
}

main
