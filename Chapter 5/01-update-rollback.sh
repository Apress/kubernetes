
kubectl create deployment nginx --image=nginx:1.10

kubectl rollout status deployment nginx

kubectl rollout history deployment nginx

kubectl set image deployment nginx nginx=nginx:1.11

kubectl rollout history deployment nginx

kubectl set image deployment nginx nginx=nginx:1.12 --record

kubectl rollout history deployment nginx

kubectl set image deployment nginx nginx=nginx:1.13

kubectl annotate deployment nginx \
  kubernetes.io/change-cause="update to revision 1.13" \
  --record=false --overwrite=true

kubectl rollout history deployment nginx

kubectl edit deployment nginx

kubectl describe pod -l app=nginx

kubectl annotate deployment nginx \
  kubernetes.io/change-cause="add FOO environment variable" \
  --record=false --overwrite=true

kubectl rollout history deployment nginx

kubectl rollout undo deployment nginx

kubectl rollout history deployment nginx

kubectl rollout undo deployment nginx --to-revision=3

kubectl rollout history deployment nginx
