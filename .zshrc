#!/bin/zsh
alias zp='. ${ZPROFILE}'
alias ll='ls -la'
alias confsh='confsh'

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
export GITHUB_ALGO="${GITHUB}/algo"
export GITHUB_SHCONF="${GITHUB}/shconf"

# load profiles
export SHCONF_LIST_DIR="${GITHUB_SHCONF}/conf"
for CONF in $(ls ${SHCONF_LIST_DIR}/* | realpath); do
	. ${CONF}
done

function confsh() {
	zsh ${GITHUB_SHCONF}/setup.sh
	. ${ZPROFILE}
}

function realpath() {
	function realpath_inner() {
		local P="$@"
		local BASE
		local DIR
		if [ -f "${P}" ]; then
			BASE="/$(basename "${P}")"
			DIR="$(dirname "${P}")"
		elif [ -d "${P}" ]; then
			DIR="${P}"
		fi
		DIR="$(cd "${DIR}" && pwd)"
		echo "${DIR}${BASE}"
	}

	local ARGS
	if [ -p /dev/stdin ]; then
		if [[ "$(echo $@)" == "" ]]; then
			ARGS=($(cat -))
		else
			ARGS=($@)
		fi
	else
		ARGS=($@)
	fi

	for P in ${ARGS[*]}; do
		realpath_inner ${P}
	done
}

function bar() {
	local REP="$1"
	local N="$2"
	local MESSAGE="$3"
	printf "%${N}s\n" | sed "s/ /${REP}/g"
	[[ "${MESSAGE}" != "" ]] && message "${MESSAGE}"
}

function message() {
	local MESSAGE="$1"
	printf "$(color bold)${MESSAGE}$(color)\n"
}

function now() {
	date '+%Y-%m-%d %H:%M:%S'
}
