gcloud compute firewall-rules create \
  kubernetes-cluster-allow-external-ingress \
  --allow tcp:$HTTP_PORT,tcp:$HTTPS_PORT \
  --network kubernetes-cluster \
  --source-ranges 0.0.0.0/0

WORKER_IP=$(gcloud compute instances describe worker-0 \
  --zone $(gcloud config get-value compute/zone) \
  --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
