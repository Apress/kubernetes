sudo kubeadm join 10.240.0.10:6443 --token <token> \
    --discovery-token-ca-cert-hash sha256:<hash>

openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | \
   openssl rsa -pubin -outform der 2>/dev/null | \
   openssl dgst -sha256 -hex | sed 's/^.* //'
