# Add GPG key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Add Kubernetes apt repository
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Get Kubernetes apt repository data
sudo apt-get update

# List available versions of kubeadm
apt-cache madison kubeadm

# Install selected version (here 1.18.6-00)
sudo apt-get install -y kubelet=1.18.6-00 kubeadm=1.18.6-00 kubectl=1.18.6-00
sudo apt-mark hold kubelet kubeadm kubectl
