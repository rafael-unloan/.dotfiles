#!/usr/bin/env bash

# install homebrew
# pipe from echo to avoid prompt
# https://github.com/Homebrew/legacy-homebrew/issues/46779#issuecomment-162819088
echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add homebrew to path
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "${HOME}/.zshrc"
source "${HOME}/.zshrc"

# install apps
brew install gh

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

EOF

# install docker containers
docker run --restart always -d -v /var/run/docker.sock:/var/run/docker.sock -p 9988:8080 --name dozzle amir20/dozzle:latest

# update vscode to use tmux as the default terminal
sed -i 's/"terminal\.integrated\.defaultProfile\.\(linux\|osx\)": ".*"/"terminal.integrated.defaultProfile.\1": "tmux"/g' ~/core/.vscode/settings.json
git update-index --assume-unchanged ~/core/.vscode/settings.json
