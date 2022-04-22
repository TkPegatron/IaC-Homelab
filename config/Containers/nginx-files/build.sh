pushd fancyindex-bootstrap
make
popd
#podman rm -f nginx-fancy
podman build -t nginx-fancy . || docker build -t nginx-fancy .
#podman run -d --rm --name nginx-fancy -p 8081:80  -v /home/eperry/Documents/Projects:/usr/share/nginx/html:Z localhost/nginx-fancy:latest
