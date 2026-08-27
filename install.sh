#!/bin/bash

DRY_RUN=false
for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=true ;;
    esac
done

mkdir -p ${HOME}/.local/bin/ ${HOME}/.local/lib/ ${HOME}/.local/share/man/man1/ ${HOME}/.local/share/man/man5/

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

install_nvim() {
    local url_base="https://github.com/neovim/neovim/releases/download/v0.12.5"
    local archive="nvim-linux-x86_64.tar.gz"
    local checksum="bce0f56eda1f1b1db6eee8f4133d7a38813ea07933837dd1777411ca384c6875"

    echo "Installing Neovim..."
    wget "$url_base/$archive" -q

    if ! echo "$checksum  $archive" | sha256sum --check --status; then
        echo "Error: Checksum verification failed! The file may be corrupted or tampered with."
        rm "$archive"
        return 1
    fi

    if $DRY_RUN; then
        echo "Dry run: checksum verified, skipping Neovim install."
        rm "$archive"
        return 0
    fi

    tar -xf ${archive} -C ${HOME}/.local/lib
    rm -r ${archive}

    ln -sf ${HOME}/.local/lib/nvim-linux-x86_64/bin/nvim ${HOME}/.local/bin/nvim

    # config install
    ln -s ${SCRIPT_DIR}/nvim ${HOME}/.config/nvim
    echo "Neovim installed!"
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

    if $DRY_RUN; then
        echo "Dry run: checksum verified, skipping eza install."
        rm "$archive"
        return 0
    fi

    tar -xf "${archive}"
    rm "${archive}"

    mv eza "${install_location}"
    echo "eza installed!"
}

install_fzf() {
    local url_base="https://github.com/junegunn/fzf/releases/download/v0.74.3"
    local archive="fzf-0.74.3-linux_amd64.tar.gz"
    local install_location="${HOME}/.local/bin"
    local checksum="3501a595e4b5c40a6b047340a0e8f805c46fd4e61ef95ef8a136ba8c61cf6f22"

    echo "Installing fzf..."
    wget "${url_base}/${archive}" -q

    if ! echo "$checksum  $archive" | sha256sum --check --status; then
        echo "Error: Checksum verification failed! The file may be corrupted or tampered with."
        rm "$archive"
        return 1
    fi

    if $DRY_RUN; then
        echo "Dry run: checksum verified, skipping fzf install."
        rm "$archive"
        return 0
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

if $DRY_RUN; then
    install_fzf
    install_nvim
    install_eza
fi

# if no glibc > 2.29 or smth just install a new one and libm (most likely) to $LD_LIBRARY_PATH (add to bashrc
# need options to install from source, also check versioning
