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


main(){
    echo_text "Installing Applications"
    sudo pacman -S --needed --noconfirm fish ghostty zed uv starship firefox neovim git ttf-jetbrains-mono-nerd
    echo "Packages Installed"

    echo_text "Setting up configurations"
    cd $HOME
    [ ! -d "Github" ] && mkdir "Github"
    cd ./Github/
    [ ! -d "dotfiles" ] && git clone https://github.com/aditya27gupta/dotfiles.git
    echo "Pulled the dotfiles repository"

    # echo "Pulling Repositories for zsh"
    # cd zsh_plugin
    # git clone https://github.com/zsh-users/zsh-autosuggestions.git
    # git clone https://github.com/zsh-users/zsh-completions.git

    echo_text "Placing all the dotfiles"
    python3 ./dotfiles/config_placer.py
    echo "Placed all the dotfiles"
}

main
