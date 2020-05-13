function message() {
	local MESSAGE="$1"
	local COLOR="$2"
	printf "${COLOR}${MESSAGE}$(color)\n"
}

function now() {
	date '+%Y-%m-%d %H:%M:%S'
}
