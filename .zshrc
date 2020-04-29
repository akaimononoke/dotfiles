#!/bin/zsh
alias zp='. ${ZPROFILE}'
alias ll='ls -la'
alias confsh='confsh'

# Setup zsh-completions
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	autoload -Uz compinit
	compinit
fi

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
