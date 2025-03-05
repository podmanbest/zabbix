```sh
# Build Image
podman build -t nginx:v3.16 .

# Run container by Image
podman run -d -p 8080:80 --name nginx nginx:v3.16

podman run -d \
  --pod lamp-pod \
  --name nginx \
  -v app-data:/var/www/html \
  -v ./nginx.conf:/etc/nginx/nginx.conf \
  docker.io/library/nginx:alpine

# Console Container
podman exec -ti webserver /bin/sh