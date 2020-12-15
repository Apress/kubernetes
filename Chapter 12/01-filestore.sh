gcloud filestore instances create nfs-server \
   --project=$(gcloud config get-value project) \
   --zone=$(gcloud config get-value compute/zone) \
   --tier=STANDARD \
   --file-share=name="vol1",capacity=1TB \
   --network=name="kubernetes-cluster"

gcloud filestore instances describe nfs-server \
   --project=$(gcloud config get-value project) \
   --zone=$(gcloud config get-value compute/zone)
