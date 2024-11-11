# ZSH settings

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="clean"
plugins=(git)
ENABLE_CORRECTION=false
source $ZSH/oh-my-zsh.sh

# Environment variables

set -o vi

export VISUAL=nvim
export EDITOR=nvim
# export TERM="tmux-256color"

export GOPATH=$HOME/go
export GOBIN=$HOME/.local/bin

# Path configuration

path=(
	$path
	$HOME/bin
	$HOME/.local/bin
  /usr/local/go/bin
	/opt/nvim-linux64/bin
)

typeset -U path
path=($^path(N-/))

export PATH

# homebrew activate

if [ -d "/home/linuxbrew/.linuxbrew" ]; then
     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
