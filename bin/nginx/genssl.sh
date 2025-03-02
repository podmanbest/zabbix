sleep 10
openssl genrsa 2048 > ./ca.key
openssl req -new -x509 -nodes -days 730 -key ./ca.key -out ./ca.crt -subj "/C=US/ST=California/L=San Francisco/O=Adminbyaccident Ltd/CN=example.com/emailAddress=youremail@anymail.com"
openssl req -newkey rsa:2048 -days 730 -nodes -keyout ./server.key -out ./server.req -subj "/C=US/ST=State/L=City/O=Adminbyaccident Ltd/CN=example.com/emailAddress=youremail@anymail.com"
openssl rsa -in ./server.key -out ./server.key
openssl x509 -req -in ./server.req -days 730 -CA ./ca.crt -CAkey ./ca.key -set_serial 0100 -out ./server.crt
openssl verify -CAfile ./ca.crt ./server.crt