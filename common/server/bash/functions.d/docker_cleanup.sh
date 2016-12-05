# from http://stackoverflow.com/a/32564760/14878
function docker_cleanup() {
  docker ps -f status=exited -q | xargs -r docker rm
  docker images -f dangling=true -q | xargs -r docker rmi
}
