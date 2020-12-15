gcloud config set compute/zone us-west1-c # or your selected zone

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute instances describe controller \
  --zone $(gcloud config get-value compute/zone) \
  --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

sudo kubeadm init \
  --pod-network-cidr=10.244.0.0/16 \
  --ignore-preflight-errors=NumCPU \
  --apiserver-cert-extra-sans=$KUBERNETES_PUBLIC_ADDRESS

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
