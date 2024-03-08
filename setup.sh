#!/bin/bash

# create directories

export CONFIG_HOME="$HOME"/.config

mkdir "$CONFIG_HOME"

ln -sf "$PWD/nvim/" "$CONFIG_HOME"/nvim
ln -sf "$PWD/.tmux.conf/" "$HOME"/.tmux.conf

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

apt install -y gcc g++ unzip

add-apt-repository ppa:neovim-ppa/stable
apt-get update -y
apt-get install neovim -y
