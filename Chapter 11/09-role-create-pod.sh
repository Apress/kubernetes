kubectl create role role-create-pod --resource=pods --verb=create

kubectl create rolebinding role-create-pod --role=role-create-pod --user=user
