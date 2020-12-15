kubectl create deployment webapp --image=httpd

kubectl expose deployment webapp --port 80

kubectl apply -f - <<EOF
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: webapp-ingress
spec:
  backend:
    serviceName: webapp
    servicePort: 80
EOF
