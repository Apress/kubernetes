gcloud beta container clusters delete "kluster" \
   --project $(gcloud config get-value project) \
   --zone $(gcloud config get-value compute/zone)
