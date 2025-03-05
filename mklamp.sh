#!/bin/sh

echo -e "Building Apache PHP image"
id=$(buildah from --pull docker.io/php:7.4.10-apache-buster)
buildah run $id docker-php-ext-install pdo pdo_mysql
buildah commit $id php-apache

echo -e "\nBuilding MySQL image"
id=$(buildah from --pull docker.io/mysql:8)
buildah commit $id php-mysql

echo -e "\nBuilding phpmyadmin image"
id=$(buildah from --pull docker.io/phpmyadmin:latest)
buildah commit $id php-pma

podman pod create --name pod-lamp -p 8000:80 && podman pod start pod-lamp
podman network create lamp-net
podman volume create mysqldb
podman volume create src

podman run \
    --detach \
    --pod pod-lamp \
    --publish 8000:80 \
    --name php-dev \
    --volume src:/var/www/html \
    php-apache

podman run \
    --detach \
    --pod pod-lamp \
    --name mysql-dev \
    --env MYSQL_ROOT_PASSWORD=dev \
    --security-opt label=disable \
    --volume mysqldb:/var/lib/mysql \
    --network lamp-net \
    --restart on-failure \
    php-mysql

podman run \
    --pod pod-lamp \
    --name pma \
    --security-opt label=disable \
    -e PMA_HOST=127.0.0.1 \
    -e PMA_PORT=8080 \
   php-pma