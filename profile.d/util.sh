function message() {
	local message="$1"
	local color="$2"
	printf "${color}${message}$(color)\n"
}

function now() {
	date '+%Y-%m-%d %H:%M:%S'
}
