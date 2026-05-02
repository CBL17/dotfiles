#!/bin/bash

mkdir -p ${HOME}/.local/bin/ ${HOME}/.local/lib/ ${HOME}/.local/share/man/man1/ ${HOME}/.local/share/man/man5/

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

install_nvim() {
    local url_base="https://github.com/neovim/neovim/releases/download/v0.12.1"
    local archive="nvim-linux-x86_64.tar.gz"
    local checksum="e59a5eafcdf824e2bf6a738e75f8f62ba4ff1b7f1c7daaec2d134aa46737907c"

    wget "$url_base/$archive" -q

    if ! echo "$checksum  $archive" | sha256sum --check --status; then
        echo "Error: Checksum verification failed! The file may be corrupted or tampered with."
        rm "$archive"
        return 1
    fi

    tar -xf ${archive} -C ${HOME}/.local/lib
    rm -r ${archive}

    ln -sf ${HOME}/.local/lib/nvim-linux-x86_64/bin/nvim ${HOME}/.local/bin/nvim

    # config install
    ln -s ${SCRIPT_DIR}/nvim ${HOME}/.config/nvim
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

install_fzf() {
    local url_base="https://github.com/junegunn/fzf/releases/download/v0.72.0"
    local archive="fzf-0.72.0-linux_amd64.tar.gz"
    local install_location="${HOME}/.local/bin"
    local checksum="0e58e4bd0b3c5d68c56b54c460a6863d0de79633ed18d388575a960ab447b006"

    echo "Installing fzf..."
    wget "${url_base}/${archive}" -q

    if ! echo "$checksum  $archive" | sha256sum --check --status; then
        echo "Error: Checksum verification failed! The file may be corrupted or tampered with."
        rm "$archive"
        return 1
    fi

    tar -xf "${archive}"
    rm "${archive}"

    mv fzf "${install_location}"
    echo "fzf installed!"
}

install_bashrc() {
    local sourceme_path="${SCRIPT_DIR}"/bash/SOURCEME
    echo -e "\nsource ${sourceme_path}" >> ${HOME}/.bashrc
}

# if no glibc > 2.29 or smth just install a new one and libm (most likely) to $LD_LIBRARY_PATH (add to bashrc
# need options to install from source, also check versioning
