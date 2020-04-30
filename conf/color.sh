export CHAR_BLACK=$(tput setaf 0)
export CHAR_RED=$(tput setaf 1)
export CHAR_GREEN=$(tput setaf 2)
export CHAR_YELLOW=$(tput setaf 3)
export CHAR_BLUE=$(tput setaf 4)
export CHAR_MAGENTA=$(tput setaf 5)
export CHAR_CYAN=$(tput setaf 6)
export CHAR_WHITE=$(tput setaf 7)
export CHAR_BOLD=$(tput bold)
export CHAR_UNSET=$(tput sgr0)

function color() {
	if [ $# -eq 0 ]; then
		printf ${CHAR_UNSET}
		return 0
	fi
	for ARG in $*; do
		case "${ARG}" in
		black | bk) printf ${CHAR_BLACK} ;;
		red | r) printf ${CHAR_RED} ;;
		green | g) printf ${CHAR_GREEN} ;;
		blue | b) printf ${CHAR_BLUE} ;;
		magenta | m) printf ${CHAR_MAGENTA} ;;
		cyan | c) printf ${CHAR_CYAN} ;;
		white | w) printf ${CHAR_WHITE} ;;
		bold) printf ${CHAR_BOLD} ;;
		esac
	done
}
