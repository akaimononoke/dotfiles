#!/bin/zsh
alias zp='. ${ZPROFILE}'
alias ll='ls -la'
alias confsh='zsh ${SHCONF}/setup.sh && . ${ZPROFILE}'

# profiles
ZPROFILE="${HOME}/.zprofile"
ZSHRC="${HOME}/.zshrc"

# prompt
export PROMPT="%n@%m %F{4}%~%F{sgr0} $ "

# zsh-completions
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	autoload -U compinit
	compinit -u
fi

# pyenv
export PYENV_ROOT="/usr/local/var/pyenv"
export PATH="${PATH}:${PYENV_ROOT}/bin"
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi

# go
export GOPATH="$(go env GOPATH)"
export GOBIN="$(go env GOBIN)"
export GOPKG="${GOPATH}/pkg"
export GOSRC="${GOPATH}/src"
export PATH="${PATH}:${GOBIN}"

# rust
export CARGO_HOME="${HOME}/.cargo"
export PATH="${PATH}:${CARGO_HOME}/bin"

# git
export GITHUB="${GOSRC}/github.com"
export YAKAMON="${GITHUB}/yakamon"
export ALGO="${YAKAMON}/algo"
export SHCONF="${YAKAMON}/shconf"

# load
for FILE in $(ls ${SHCONF}/conf/*); do
	. "${SHCONF}/conf/${FILE}"
done

# update
update_onload
