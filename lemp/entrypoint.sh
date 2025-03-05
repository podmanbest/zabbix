#!/bin/sh

# Replace environment variables in the nginx.conf.template file
envsubst '${PHP_FPM_HOST} ${PHP_FPM_PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start NGINX
exec nginx -g "daemon off;"