podman pod create --name zabbix \
      -p 8080:8080 \
      -p 8443:8443 \
      -p 10051:10051

podman run --name zb-data -t \
      -e MYSQL_DATABASE="zabbix" \
      -e MYSQL_USER="zabbix" \
      -e MYSQL_PASSWORD="zabbix_pwd" \
      -e MYSQL_ROOT_PASSWORD="root_pwd" \
      -v ./data:/var/lib/mysql:Z \
      --restart=always \
      --pod=zabbix \
      -d mysql:8.0 \
      --character-set-server=utf8 --collation-server=utf8_bin \
      --default-authentication-plugin=mysql_native_password

podman run --name zb-gateway -t \
      --restart=always \
      --pod=zabbix \
      -d docker.io/zabbix/zabbix-java-gateway:latest

podman run --name zb-server -t \
      -e DB_SERVER_HOST="zb-data" \
      -e MYSQL_DATABASE="zabbix" \
      -e MYSQL_USER="zabbix" \
      -e MYSQL_PASSWORD="zabbix_pwd" \
      -e MYSQL_ROOT_PASSWORD="root_pwd" \
      -e ZBX_JAVAGATEWAY="zb-gateway" \
      --restart=always \
      --pod=zabbix \
      -d docker.io/zabbix/zabbix-server-mysql:latest

podman run --name zb-agent \
      -e ZBX_SERVER_HOST="zb-server" \
      --restart=always \
      --pod=zabbix \
      -d docker.io/zabbix/zabbix-agent:latest

podman run --name zb-web -t \
      -e ZBX_SERVER_HOST="zb-server" \
      -e DB_SERVER_HOST="zb-data" \
      -e MYSQL_DATABASE="zabbix" \
      -e MYSQL_USER="zabbix" \
      -e MYSQL_PASSWORD="zabbix_pwd" \
      -e MYSQL_ROOT_PASSWORD="root_pwd" \
      -e PHP_TZ="Asia/Jakarta" \
      --restart=always \
      --pod=zabbix \
      -d docker.io/zabbix/zabbix-web-nginx-mysql:latest

# extentions
#podman run --name browser \
#      -p 4444:4444 \
#      -p 7900:7900 \
#      --shm-size="2g" \
#     -d selenium/standalone-chrome:latest
