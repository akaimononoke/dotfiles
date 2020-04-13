#!/bin/zsh
[ -f ${HOME}/.zshrc ] && . ${HOME}/.zshrc

# Pyenv
export PYENV_ROOT=/usr/local/var/pyenv
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi

# Go
export GOPATH="$(go env GOPATH)"
export GOBIN="$(go env GOBIN)"
export GOPKG="${GOPATH}/pkg"
export GOSRC="${GOPATH}/src"
export PATH="${PATH}:${GOBIN}"

# Git Repository
export GIT_ALGO="${GOSRC}/algo"
export GIT_SHCONF="${GOSRC}/shconf"

# Shell Configuration
export SHELL_CONFIGS="${GIT_SHCONF}/conf"

# Load Profiles
for FILE in $(ls ${SHELL_CONFIGS}); do
	. ${SHELL_CONFIGS}/${FILE}
done
