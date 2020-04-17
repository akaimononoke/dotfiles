alias dobuild='docker-compose build'
alias doup='docker-compose up -d'
alias dodown='docker-compose down'
alias dossh='docker_ssh'

function docker_ssh() {
    local CONTAINER_NAME="$1"
    local SHELL="$2"
    docker exec -it "${CONTAINER_NAME}" "${SHELL}" -l
}
