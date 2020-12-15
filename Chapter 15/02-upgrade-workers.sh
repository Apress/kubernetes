kubectl drain worker-0 --ignore-daemonsets

sudo apt update && \
   sudo apt-get install \
   -y --allow-change-held-packages \
   kubeadm=1.19.0-00

sudo apt-mark hold kubeadm

kubeadm version -o short

sudo kubeadm upgrade node

sudo apt-get update && \
   sudo apt-get install \
   -y --allow-change-held-packages \
   kubelet=1.19.0-00 kubectl=1.19.0-00

sudo apt-mark hold kubelet kubectl

kubectl uncordon worker-0
