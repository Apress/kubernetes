kubectl create deployment nginx --image=nginx

kubectl set resources deployment nginx \
  --requests=cpu=0.1,memory=1Gi
