CLUSTER_ENDPOINT=$(kubectl config view --minify --raw -o jsonpath='{.clusters[0].cluster.server}')
CLUSTER_CA=$(kubectl config view --minify --raw -o jsonpath='{.clusters[0].cluster.certificate-authority-data}')
echo -n $CLUSTER_CA | base64 -d > cluster.crt
CLUSTER_NAME=$(kubectl config view --minify --raw -o jsonpath='{.clusters[0].name}')
kubectl --kubeconfig=saconfig config set-cluster $CLUSTER_NAME \
   --server=$CLUSTER_ENDPOINT \
   --certificate-authority=cluster.crt --embed-certs

USER_NAME=kubectl
SECRET_NAME=$(kubectl get sa kubectl -o jsonpath='{.secrets[0].name}')
TOKEN=$(kubectl get secrets $SECRET_NAME -o jsonpath='{.data.token}' | base64 -d)
kubectl --kubeconfig=saconfig config set-credentials $USER_NAME \
   --token=$TOKEN

kubectl --kubeconfig=saconfig config set-context default \
   --cluster=$CLUSTER_NAME \
   --user=$USER_NAME \
   --namespace=default

kubectl --kubeconfig=saconfig config use-context default
