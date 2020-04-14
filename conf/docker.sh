alias dosh='docker_ssh'

function docker_ssh() {
    local CONTAINER_NAME="$1"
    local SHELL="$2"
    docker exec -it "${CONTAINER_NAME}" "${SHELL}" -l
}
