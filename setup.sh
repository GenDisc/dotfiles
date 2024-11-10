#!/bin/bash

# create directories

DOTFILES_DIR="$HOME/dotfiles"
XDG_CONFIG_HOME="$HOME/.config"

create_directories() {
  local directories=("$@")
  for dir in "${directories[@]}"; do
    mkdir -p "$dir"
  done
}

create_symlinks() {
  local items=("$@")
  for item in "${items[@]}"; do
    IFS=':' read -r source target <<<"$item"
    if [ -L "$target" ]; then
      echo "Removing existing symlink $target"
      unlink "$target"
    elif [ -d "$target" ]; then
      echo "Warning: $target is a directory. Skipping..."
      continue
    elif [ -e "$target" ]; then
      echo "Warning: $target already exists. Skipping..."
      continue
    fi
    ln -s "$DOTFILES_DIR/$source" "$target"
    echo "Created symlink for $source"
  done
}

common_directories=(
  "$XDG_CONFIG_HOME/k9s"
  "$XDG_CONFIG_HOME/qutebrowser"
  "$XDG_CONFIG_HOME/waybar"
  "$HOME/check"
  "$HOME/miniconda3"
)

common_items=(
  "k9s/skin.yml:$XDG_CONFIG_HOME/k9s/skin.yml"
  ".tmux.conf:$HOME/.tmux.conf"
  "nvim:$XDG_CONFIG_HOME/nvim"
  ".zprofile:$HOME/.zprofile"
  ".zshrc:$HOME/.zshrc"
  "qutebrowser/config.py:$XDG_CONFIG_HOME/qutebrowser/config.py"
  "waybar/config.jsonc:$XDG_CONFIG_HOME/waybar/config.jsonc"
  "waybar/style.css:$XDG_CONFIG_HOME/waybar/style.css"
)

create_directories "${common_directories[@]}"
create_symlinks "${common_items[@]}"

export TZ=Asia/Seoul

# Linux specific setup
if [[ "$OSTYPE" == linux* ]]; then
  apt update -y
  apt install -y gcc g++ unzip python3-pip python3-venv curl wget npm fd-find zsh
  chsh -s $(which zsh)
  curl -LO https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz
  tar -C /opt -xzf nvim-linux64.tar.gz
  rm nvim-linux64.tar.gz

  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
  bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
  rm -rf ~/miniconda3/miniconda.sh


  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  install lazygit /usr/local/bin
fi

# install homebrew
if command -v brew &> /dev/null
then
    echo "Homebrew is already installed."
else
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null
fi

# MacOS specific setup
if [[ "$OSTYPE" == darwin* ]]; then
  macos_directories=(
    "$HOME/.qutebrowser"
  )
  macos_items=(
    "qutebrowser/config.py:$HOME/.qutebrowser/config.py"
  )
  create_directories "${macos_directories[@]}"
  create_symlinks "${macos_items[@]}"

  curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda3/miniconda.sh
  bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
  rm ~/miniconda3/miniconda.sh

  brew install lazygit
  brew install neovim

fi


chsh -s $(which zsh)

exec zsh
# conda config --add channels conda-forge
# conda config --set channel_priority strict


