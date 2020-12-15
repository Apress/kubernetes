kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=<path/to/.docker/config.json> \
    --type=kubernetes.io/dockerconfigjson

kubectl create secret docker-registry regcred \
   --docker-server=$DOCKER_REGISTRY_SERVER \
   --docker-username=$DOCKER_USER \
   --docker-password=$DOCKER_PASSWORD \
   --docker-email=$DOCKER_EMAIL
