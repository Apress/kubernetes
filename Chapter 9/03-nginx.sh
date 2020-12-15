cat <<EOF | sudo tee /etc/kubernetes/manifests/nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
EOF
