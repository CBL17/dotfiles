#!/bin/bash

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

install_eza() {
    local url_base="https://github.com/eza-community/eza/releases/download/v0.23.4"
    local archive="eza_x86_64-unknown-linux-gnu.tar.gz"
    local install_location="${HOME}/.local/bin"
    local checksum="0c38665440226cd8bef5d1d4f3bc6ff77c927fb0d68b752739105db7ab5b358d"

    echo "Installing eza..."
    wget "${url_base}/${archive}" -q

    if ! echo "$checksum  $archive" | sha256sum --check --status; then
        echo "Error: Checksum verification failed! The file may be corrupted or tampered with."
        rm "$archive"
        return 1
    fi

    tar -xf "${archive}"
    rm "${archive}"

    mv eza "${install_location}"
    echo "eza installed!"
}

install_bashrc() {
    local script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
    local sourceme_path="${script_dir}"/bash/SOURCEME
    echo -e "\nsource ${sourceme_path}" >> ~/.bashrc
}

# if no glibc > 2.29 or smth just install a new one and libm (most likely) to $LD_LIBRARY_PATH (add to bashrc
# need options to install from source, also check versioning
