alias dobuild='docker-compose build'
alias dodown='docker-compose down'
alias dops='docker ps'
alias dossh='docker_ssh'
alias doup='docker-compose up -d'

function docker_ssh() {
    local container_name="$1"
    local shell_name="$2"

    docker exec -it "${container_name}" "${shell_name}" -l
}
