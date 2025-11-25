#!/usr/bin/env bash

# install homebrew
# pipe from echo to avoid prompt
# https://github.com/Homebrew/legacy-homebrew/issues/46779#issuecomment-162819088
echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add homebrew to path
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "${HOME}/.zshrc"
source "${HOME}/.zshrc"

# install apps
brew install gh neovim ripgrep bat delta fd fzf

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt-get update
sudo apt-get install build-essential # for cc

npm install -g @github/copilot

# misc - zsh vi mode and keybindings
cat << 'EOF' >> ~/.zshrc
set -o vi
# Allow forward search
stty -ixon

bindkey -v
bindkey "^H" backward-kill-word
bindkey "^?" backward-delete-char
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
EOF

cat << 'EOF' >> ~/.tmux.conf
set -g default-shell /bin/zsh
set -g mouse on

bind C-h select-pane -L  # move left
bind C-j select-pane -D  # move down
bind C-k select-pane -U  # move up
bind C-l select-pane -R  # move right
EOF

# install docker containers
docker run --restart always -d -v /var/run/docker.sock:/var/run/docker.sock -p 9988:8080 --name dozzle amir20/dozzle:latest
