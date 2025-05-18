#!/bin/bash

# Exits script on any failure
set -e

mkdir -p ~/.local/bin/ ~/.local/lib/ ~/.local/share/man/man1/ ~/.local/share/man/man5/

install_nvim() {
    local url_base="https://github.com/neovim/neovim/releases/download/stable"
    local tar_name="nvim-linux-x86_64.tar.gz"

    wget "$url_base/$tar_name" -q
    wget "$url_base/$tar_name.sha256sum" -q

    sha256sum -c "$tar_name.sha256sum" --quiet
    rm "$tar_name.sha256sum"

    tar -xf "$tar_name" -C .
    rm -r "$tar_name"

    mv ./nvim-linux-x86_64/ ~/.local/lib/nvim-linux-x86_64
    ln -sf ~/.local/lib/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim

    # config install
    ln -s ./nvim ~/.config/nvim
}

install_exa() {
    local url_base="https://github.com/ogham/exa/releases/download/v0.10.1"
    local archive="exa-linux-x86_64-v0.10.1.zip"

    wget "$url_base/$archive" -q

    unzip "$archive" -d exa
    rm -r "$archive"

    mv ./exa/bin/exa ~/.local/bin
    mv ./exa/man/exa.1 ~/.local/share/man/man1
    mv ./exa/man/exa_colors.5 ~/.local/share/man/man5

    rm -r exa
}

# if no glibc > 2.29 or smth just install a new one and libm (most likely) to $LD_LIBRARY_PATH (add to bashrc
# need options to install from source, also check versioning
