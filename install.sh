#!/bin/bash

# Exits script on any failure
set -e

mkdir -p ~/.local/bin/
mkdir -p ~/.local/lib/
mkdir -p ~/.local/share/man/man1/
mkdir -p ~/.local/share/man/man5/

install_nvim() {
    # nvim binary install
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz -q
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz.sha256sum -q

    sha256sum -c nvim-linux64.tar.gz.sha256sum --quiet

    rm nvim-linux64.tar.gz.sha256sum

    tar -xf nvim-linux64.tar.gz nvim-linux64
    rm -r nvim-linux64.tar.gz

    mv ./nvim-linux64/ ~/.local/lib/nvim
    ln -s ~/.local/lib/nvim/bin/nvim ~/.local/bin/nvim

    # config install
    ln -s ./nvim ~/.config/nvim
}

install_exa() {
    wget https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip -q

    unzip exa-linux-x86_64-v0.10.1.zip -d exa
    rm -r exa-linux-x86_64-v0.10.1.zip

    mv ./exa/bin/exa ~/.local/bin
    mv ./exa/man/exa.1 ~/.local/share/man/man1
    mv ./exa/man/exa_colors.5 ~/.local/share/man/man5

    rm -r exa
}

# if no glibc > 2.29 or smth just install a new one and libm (most likely) to $LD_LIBRARY_PATH (add to bashrc
# need options to install from source, also check versioning
