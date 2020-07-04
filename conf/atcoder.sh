function atcodermkdir() {
    CONTEST_NAME="$1"
    PROBLEM_CODE="$2"
    INPUT_NUM="$3"

    if [ $# -lt 1 ]; then
        printf "usage: atcoder-mkdir <contest_name> <problem_code> <number_of_input_files>\n"
        exit 0
    fi

    if [ $INPUT_NUM -gt 26 ]; then
        printf "too many input files.\n"
        exit 1
    fi

    mkdir -p ${CONTEST_NAME}/${PROBLEM_CODE}/input
    for i in {0..$((INPUT_NUM - 1))}; do
        touch ${CONTEST_NAME}/${PROBLEM_CODE}/input/$(printf "%b\n" $(printf '%s%x' '\x' $((97 + i))))
    done
}
