#!/bin/bash

# create directories

export CONFIG_HOME="$HOME"/.config

mkdir "$CONFIG_HOME"

ln -sf "$PWD/nvim/" "$CONFIG_HOME"/nvim
ln -sf "$PWD/.tmux.conf/" "$HOME"/.tmux.conf
ln -sf "$PWD/.bashrc" "$HOME"/.bashrc

source "$HOME"/.bashrc

apt-get update -y
apt install -y gcc g++ unzip
apt install -y curl
apt install fd-find
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
