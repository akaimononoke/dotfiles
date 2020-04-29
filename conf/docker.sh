alias dobuild='docker-compose build'
alias dodown='docker-compose down'
alias dops='docker ps'
alias dossh='docker_ssh'
alias doup='docker-compose up -d'

function docker_ssh() {
    local CONTAINER_NAME="$1"
    local SHELL="$2"
    docker exec -it "${CONTAINER_NAME}" "${SHELL}" -l
}
