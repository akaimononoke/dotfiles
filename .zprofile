#!/bin/zsh
ZPROFILE="${HOME}/.zprofile"
ZSHRC="${HOME}/.zshrc"
[ -f ${ZSHRC} ] && . ${ZSHRC}

# Prompt
export PROMPT="%n@%m %F{4}%~%F{sgr0} $ "

# Pyenv
export PYENV_ROOT="/usr/local/var/pyenv"
export PATH="${PATH}:${PYENV_ROOT}/bin"
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

# Load Profiles
export SHCONF_LIST_DIR="${GITHUB_SHCONF}/conf"
for CONF in $(ls ${SHCONF_LIST_DIR}/* | realpath); do
	. ${CONF}
done
