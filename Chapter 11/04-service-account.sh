# Create a service account for a kubectl pod
kubectl create serviceaccount kubectl

# Get the name of the associated secret
SECRET_NAME=$(kubectl get sa kubectl -o jsonpath='{.secrets[0].name}')

# Show the secret contents
kubectl get secret $SECRET_NAME -o yaml

# Create the nodes-read cluster role
kubectl create clusterrole nodes-read \
   --verb=get,list,watch --resource=nodes

# Bind the nodes-read role to the service account kubectl in default namespace
kubectl create clusterrolebinding default-kubectl-nodes-read \
   --clusterrole=nodes-read --serviceaccount=default:kubectl

# Execute kubectl container with kubectl service account
kubectl run kubectl \
   --image=bitnami/kubectl:latest \
   --serviceaccount=kubectl \
   --command sh -- -c "sleep $((10**10))"
