FROM phpmyadmin:latest
COPY config.inc.php /etc/phpmyadmin/config.inc.php
EXPOSE 8080