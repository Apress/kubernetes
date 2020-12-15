helm repo list

helm repo add bitnami https://charts.bitnami.com/bitnami

helm install my-wp-install bitnami/wordpress

helm upgrade my-wp-install bitnami/wordpress

helm history my-wp-install

helm rollback my-wp-install 1

helm history my-wp-install

helm uninstall my-wp-install
