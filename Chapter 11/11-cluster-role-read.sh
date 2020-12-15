kubectl create clusterrole cluster-role-read --resource="*.*" --verb=get,list

kubectl create clusterrolebinding cluster-role-read --clusterrole=cluster-role-read --user=user
