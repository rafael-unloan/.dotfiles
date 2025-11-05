#!/usr/bin/env bash

# install homebrew
# pipe from echo to avoid prompt
# https://github.com/Homebrew/legacy-homebrew/issues/46779#issuecomment-162819088
echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add homebrew to path
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc

# install apps
brew install gh

# install docker containers
docker run --restart always -d -v /var/run/docker.sock:/var/run/docker.sock -p 9988:8080 --name dozzle amir20/dozzle:latest

# misc
echo 'set -o vi' >>~/.zshrc
