# Install packages to allow apt to use a repository over HTTPS
sudo apt-get update && sudo apt-get install -y \
  apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker apt repository
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

# List available versions of Docker
apt-cache madison docker-ce

# Install Docker CE, for example version 5:19.03.12~3-0
sudo apt-get update && sudo apt-get install -y \
  docker-ce=5:19.03.12~3-0~ubuntu-bionic \
  docker-ce-cli=5:19.03.12~3-0~ubuntu-bionic

sudo apt-mark hold containerd.io docker-ce docker-ce-cli

# Setup daemon
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo mkdir -p /etc/systemd/system/docker.service.d

# Restart docker
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker
