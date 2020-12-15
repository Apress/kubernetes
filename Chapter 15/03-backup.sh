kubectl exec -it -n kube-system etcd-controller \
   sh -- -c "ETCDCTL_API=3 etcdctl snapshot save snapshot.db \
   --cacert /etc/kubernetes/pki/etcd/server.crt \
   --cert /etc/kubernetes/pki/etcd/ca.crt \
   --key /etc/kubernetes/pki/etcd/ca.key"


kubectl cp -n kube-system etcd-controller:snapshot.db snapshot.db
