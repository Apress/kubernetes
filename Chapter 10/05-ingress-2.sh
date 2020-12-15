kubectl create deployment echo --image=kennship/http-echo

kubectl expose deployment echo --port 3000

kubectl delete ingress webapp-ingress

kubectl apply -f - <<EOF
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: plex-ingress
spec:
  rules:
  - host: webapp.com
    http:
      paths:
      - path: /
        backend:
          serviceName: webapp
          servicePort: 80
  - host: echo.com
    http:
      paths:
      - path: /
        backend:
          serviceName: echo
          servicePort: 3000
EOF
