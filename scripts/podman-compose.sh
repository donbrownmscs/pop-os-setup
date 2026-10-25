# load script utils
source utils/lib.sh

log 'Installing or updating Podman Compose'

# install podman-compose
exit-if-installed podman-compose

