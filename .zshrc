#!/bin/zsh
alias zp='. ${ZPROFILE}'
alias ll='ls -l'
alias confsh='confsh'

function confsh() {
	zsh ${GITHUB_SHCONF}/setup.sh
	. ${ZPROFILE}
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
