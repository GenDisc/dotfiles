#!/bin/bash

# create directories

export CONFIG_HOME="$HOME"/.config

ln -sf "$PWD/nvim/" "$CONFIG_HOME"/nvim
ln -sf "$PWD/.tmux.conf/" "$HOME"/.tmux.conf

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

apt install gcc g++ unzip

brew install neovim lazygit
