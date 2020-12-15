cat > nginx.conf <<EOF
server {
    location / {
        root /data/www;
    }

    location /images/ {
        root /data;
    }
}
EOF

kubectl create configmap config --from-file=nginx.conf
