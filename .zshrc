#!/bin/zsh
alias zp='. ${HOME}/.zprofile'
alias ll='ls -l'
alias shconf='shconf'

function shconf() {
	local CURDIR=$(pwd)
	cd ${GIT_SHCONF}
	./setup.sh
	cd ${CURDIR}
}

function bar() {
	readonly local REP
	readonly local N

	N="$2"
	REP="$1"
	printf "%${N}s\n" | sed "s/ /${REP}/g"
}
