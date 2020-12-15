openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out echo-ingress-tls.crt \
    -keyout echo-ingress-tls.key \
    -subj "/CN=echo.com/O=echo-ingress-tls"

kubectl create secret tls echo-ingress-tls \
    --key echo-ingress-tls.key \
    --cert echo-ingress-tls.crt
