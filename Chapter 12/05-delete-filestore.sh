gcloud filestore instances delete nfs-server \
   --project=$(gcloud config get-value project) \
   --zone=$(gcloud config get-value compute/zone)
