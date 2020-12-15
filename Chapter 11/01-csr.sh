openssl req -config ./csr.cnf -new -key user.key -nodes -out user.csr

# Write user CSR as base64 data
export CSR=$(cat user.csr | base64 | tr -d '\n')

# Create a template for the CertificateSigningRequest
cat > user-csr.yaml <<EOF
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: user-csr
spec:
  groups:
  - system:authenticated
  request: ${CSR}
  usages:
  - digital signature
  - key encipherment
  - server auth
  - client auth
EOF

# Insert CSR data into the template and apply it
cat user-csr.yaml | envsubst | kubectl apply -f -

# Verify CSR resource is created
kubectl get certificatesigningrequests.certificates.k8s.io user-csr

# Approve the certificate
kubectl certificate approve user-csr

# Verify CSR is approved ans issued
kubectl get certificatesigningrequests.certificates.k8s.io user-csr

# Extract the issued certificate
kubectl get csr user-csr -o jsonpath='{.status.certificate}' \
  | base64 --decode > user.crt

CLUSTER_ENDPOINT=$(kubectl config view --minify --raw -o jsonpath='{.clusters[0].cluster.server}')
CLUSTER_CA=$(kubectl config view --minify --raw -o jsonpath='{.clusters[0].cluster.certificate-authority-data}')
echo -n $CLUSTER_CA | base64 -d > cluster.crt
CLUSTER_NAME=$(kubectl config view --minify --raw -o jsonpath='{.clusters[0].name}')
kubectl --kubeconfig=userconfig config set-cluster $CLUSTER_NAME \
   --server=$CLUSTER_ENDPOINT \
   --certificate-authority=cluster.crt --embed-certs

USER_NAME=user
kubectl --kubeconfig=userconfig config set-credentials $USER_NAME \
   --client-certificate=user.crt --embed-certs

kubectl --kubeconfig=userconfig config set-context default \
   --cluster=$CLUSTER_NAME \
   --user=$USER_NAME \
   --namespace=default

 kubectl --kubeconfig=userconfig config use-context default

kubectl create clusterrole nodes-read \
   --verb=get,list,watch --resource=nodes

kubectl create clusterrolebinding user-nodes-read \
   --clusterrole=nodes-read --user=user

USER_NAME=user
kubectl --kubeconfig=userconfig config set-credentials $USER_NAME \
   --client-key=user.key --embed-certs

