sleep 10
rm -rf ./ssl
mkdir ./ssl
openssl dhparam -out ./ssl/dh2048.pem 2048
openssl genrsa 2048 > ./ssl/ca.key
openssl req -new -x509 -nodes -days 730 -key ./ssl/ca.key -out ./ssl/ca.crt -subj "/C=US/ST=California/L=San Francisco/O=Adminbyaccident Ltd/CN=example.com/emailAddress=youremail@anymail.com"
openssl req -newkey rsa:2048 -days 730 -nodes -keyout ./ssl/server.key -out ./ssl/server.req -subj "/C=US/ST=State/L=City/O=Adminbyaccident Ltd/CN=example.com/emailAddress=youremail@anymail.com"
openssl rsa -in ./ssl/server.key -out ./ssl/server.key
openssl x509 -req -in ./ssl/server.req -days 730 -CA ./ssl/ca.crt -CAkey ./ssl/ca.key -set_serial 0100 -out ./ssl/server.crt
openssl verify -CAfile ./ssl/ca.crt ./ssl/server.crt

podman build -t nginx:alpine .
