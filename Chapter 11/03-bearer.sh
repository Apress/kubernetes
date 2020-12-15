echo 22C1192A24CE822DDB2CB578BBBD8,foobar,foobar | \
   sudo tee /etc/kubernetes/pki/tokens
sudo chmod 600 /etc/kubernetes/pki/tokens

CLUSTER_ENDPOINT=$(kubectl config view --minify --raw -o jsonpath='{.clusters[0].cluster.server}')
CLUSTER_CA=$(kubectl config view --minify --raw -o jsonpath='{.clusters[0].cluster.certificate-authority-data}')
echo -n $CLUSTER_CA | base64 -d > cluster.crt
CLUSTER_NAME=$(kubectl config view --minify --raw -o jsonpath='{.clusters[0].name}')
kubectl --kubeconfig=userconfig config set-cluster $CLUSTER_NAME \
   --server=$CLUSTER_ENDPOINT \
   --certificate-authority=cluster.crt --embed-certs

USER_NAME=foobar
kubectl --kubeconfig=userconfig config set-credentials $USER_NAME \
   --token=22C1192A24CE822DDB2CB578BBBD8

kubectl --kubeconfig=userconfig config set-context default \
   --cluster=$CLUSTER_NAME \
   --user=$USER_NAME \
   --namespace=default

kubectl --kubeconfig=userconfig config use-context default

kubectl create clusterrole nodes-read \
   --verb=get,list,watch --resource=nodes

kubectl create clusterrolebinding foobar-nodes-read \
   --clusterrole=nodes-read --user=foobar

