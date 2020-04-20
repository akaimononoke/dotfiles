#!/bin/zsh
ZPROFILE="${HOME}/.zprofile"
ZSHRC="${HOME}/.zshrc"
[ -f ${ZSHRC} ] && . ${ZSHRC}

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

# Rust
export CARGO_HOME="${HOME}/.cargo"
export PATH="${PATH}:${CARGO_HOME}/bin"

# Git Repository
export GITHUB="${GOSRC}/github.com"
export GITHUB_ALGO="${GITHUB}/algo"
export GITHUB_SHCONF="${GITHUB}/shconf"

# Shell Configuration
export SHELL_CONFIGS="${GITHUB_SHCONF}/conf"

# Load Profiles
for FILE in $(ls ${SHELL_CONFIGS}); do
	. ${SHELL_CONFIGS}/${FILE}
done
