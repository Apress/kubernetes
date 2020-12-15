kubectl create role role-read --verb=get,list --resource="*.*"

kubectl create rolebinding role-read --role=role-read --user=user
