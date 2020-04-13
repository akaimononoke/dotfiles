#!/bin/zsh
alias zp='. ${HOME}/.zprofile'
alias ll='ls -l'
alias shconf='shconf'

function shconf() {
	local CURDIR=$(pwd)
	cd ${GIT_SHCONF}
	./setup.sh
	cd ${CURDIR}
	. ${HOME}/.zprofile
}

function bar() {
	local REP="$1"
	local N="$2"
	local MESSAGE="$3"
	printf "%${N}s\n" | sed "s/ /${REP}/g"
	[[ "${MESSAGE}" != "" ]] && printf "$(color bold)${MESSAGE}$(color)\n"
}

function now() {
	date '+%Y-%m-%d %H:%M:%S'
}
