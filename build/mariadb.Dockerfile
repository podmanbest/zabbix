FROM alpine:latest
RUN apk add --no-cache mariadb mariadb-client
COPY init.sql /docker-entrypoint-initdb.d/
ENV MYSQL_ROOT_PASSWORD=mysecret
EXPOSE 3306
CMD ["mysqld", "--user=mysql"]