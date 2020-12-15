gcloud auth login

gcloud config set compute/region us-west1

gcloud config set compute/zone us-west1-c

gcloud config set project my-project

gcloud compute networks create kubernetes-cluster --subnet-mode custom

gcloud compute networks subnets create kubernetes \
  --network kubernetes-cluster \
  --range 10.240.0.0/24

gcloud compute firewall-rules create \
  kubernetes-cluster-allow-internal \
  --allow tcp,udp,icmp \
  --network kubernetes-cluster \
  --source-ranges 10.240.0.0/24,10.244.0.0/16

gcloud compute firewall-rules create \
  kubernetes-cluster-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network kubernetes-cluster \
  --source-ranges 0.0.0.0/0

gcloud compute addresses create kubernetes-controller \
  --region $(gcloud config get-value compute/region)

PUBLIC_IP=$(gcloud compute addresses describe kubernetes-controller \
    --region $(gcloud config get-value compute/region) \
    --format 'value(address)')

gcloud compute instances create controller \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --private-network-ip 10.240.0.10 \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --address $PUBLIC_IP

for i in 0 1; do \
  gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes; \
done
