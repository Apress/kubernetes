gcloud beta container clusters create "kluster" \
   --project $(gcloud config get-value project) \
   --zone $(gcloud config get-value compute/zone) \
   --cluster-version "1.15.12-gke.2" \
   --machine-type "g1-small" \
   --image-type "COS" \
   --disk-type "pd-standard" \
   --disk-size "30" \
   --num-nodes "1"

gcloud container clusters get-credentials kluster \
   --zone $(gcloud config get-value compute/zone) \
   --project $(gcloud config get-value project)
