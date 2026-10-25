# load script utils
source utils/lib.sh

# podman is only available in the 'Universe' repository
sudo apt install software-properties-common
sudo add-apt-repository -y -n universe
sudo apt update

# The optional podman-docker package makes the docker command call Podman.
log 'Installing Podman and Podman-Docker'
exit-if-installed podman
exit-if-installed podman-docker
exit-if-installed curl
exit-if-installed ca-certificates
exit-if-installed gnupg
exit-if-installed lsb-release

# Install the podman-docker wrapper without recommended apps
sudo apt install --no-install-recommends podman-docker

-- Add the docker.io and quay.io search registries to the configuration file
echo "unqualified-search-registries = ["docker.io", "quay.io"]" >> /etc/containers/registries.conf

log 'Giving current user permissions to manage Podman'
sudo groupadd podman
sudo usermod -aG podman $USER
