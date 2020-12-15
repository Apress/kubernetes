docker run --rm \
   -v '/mnt:/backup' \
   -v '/var/lib/etcd:/var/lib/etcd' \
   --env ETCDCTL_API=3 \
   'k8s.gcr.io/etcd-amd64:3.1.12' \
   /bin/sh -c \
   "etcdctl snapshot restore /backup/snapshot.db ; mv /default.etcd/member/ /var/lib/etcd/"

gcloud config set compute/zone us-west1-c # or your selected zone

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute instances describe controller \
  --zone $(gcloud config get-value compute/zone) \
  --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

sudo kubeadm init \
  --pod-network-cidr=10.244.0.0/16 \
  --ignore-preflight-errors=NumCPU \
  --apiserver-cert-extra-sans=$KUBERNETES_PUBLIC_ADDRESS \
  --ignore-preflight-errors=DirAvailable--var-lib-etcd
