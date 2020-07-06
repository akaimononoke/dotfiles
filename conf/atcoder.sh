function atcodermkdir() {
    CONTEST_NAME="$1"
    PROBLEM_CODE="$2"

    if [ $# -lt 1 ]; then
        printf "usage: atcoder-mkdir <contest_name> <problem_code>\n"
        exit 0
    fi

    if [ $# -lt 2 ]; then
        printf "too few arguments."
        exit 1
    fi

    mkdir -p ${CONTEST_NAME}/${PROBLEM_CODE}/input
}
