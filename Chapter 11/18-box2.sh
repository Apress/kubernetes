kubectl delete -f box.yaml

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: box
  name: box
spec:
  replicas: 2
  selector:
    matchLabels:
      app: box
  template:
    metadata:
      labels:
        app: box
    spec:
      containers:
      - image: yourlogin/test
        name: box
        imagePullPolicy: IfNotPresent
EOF

