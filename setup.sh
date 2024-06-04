#!/bin/bash

# create directories

export CONFIG_HOME="$HOME"/.config
export TZ=Asia/Seoul

mkdir "$CONFIG_HOME"

ln -sf "$PWD/nvim/" "$CONFIG_HOME"/nvim
ln -sf "$PWD/.tmux.conf/" "$HOME"/.tmux.conf
ln -sf "$PWD/.bashrc" "$HOME"/.bashrc

apt-get update -y
apt install -y gcc g++ unzip python3-pip python3-venv
apt install -y curl wget npm
apt install fd-find
curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz
tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz

mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh

conda config --add channels conda-forge
conda config --set channel_priority strict

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit /usr/local/bin
