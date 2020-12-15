sudo apt update && apt-cache policy kubeadm

sudo apt update && \
   sudo apt-get install \
   -y --allow-change-held-packages \
   kubeadm=1.19.0-00

sudo apt-mark hold kubeadm

kubeadm version -o short

kubectl drain controller --ignore-daemonsets \
   --delete-local-data

sudo kubeadm upgrade plan

sudo kubeadm upgrade apply v1.19.0

kubectl uncordon controller

sudo apt-get update && \
   sudo apt-get install \
   -y --allow-change-held-packages \
   kubelet=1.19.0-00 kubectl=1.19.0-00

sudo apt-mark hold kubelet kubectl
