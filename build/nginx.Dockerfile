FROM alpine:latest
RUN apk add --no-cache nginx
WORKDIR /var/www/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY html/ ./
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]