KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute instances describe controller \
  --zone $(gcloud config get-value compute/zone) \
  --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

sed -i "s/10.240.0.10/$KUBERNETES_PUBLIC_ADDRESS/" kubeconfig

sed -i 's/kubernetes/cka/' kubeconfig

KUBECONFIG=$HOME/.kube/config:kubeconfig \
  kubectl config view --merge --flatten > config \
  && mv config $HOME/.kube/config

kubectl config use-context cka-admin@kubernetes
