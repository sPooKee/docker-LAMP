FROM ubuntu:xenial
MAINTAINER C.Proske  <proske@webstollen.de>

ADD install-lamp.sh /usr/sbin/install-lamp
RUN install-lamp

# generate our ssl key
#ADD setupApacheSSLKey.sh /usr/sbin/setup-apache-ssl-key
#ENV SUBJECT /C=US/ST=CA/L=CITY/O=ORGANIZATION/OU=UNIT/CN=localhost
#ENV DO_SSL_LETS_ENCRYPT_FETCH false
#ENV USE_EXISTING_LETS_ENCRYPT false
#ENV EMAIL fail
#ENV DO_SSL_SELF_GENERATION true
#RUN setup-apache-ssl-key
#ENV DO_SSL_SELF_GENERATION false
#ENV CURLOPT_CAINFO /etc/ssl/certs/ca-certificates.crt

# here are the ports that various things in this container are listening on
# for http (apache, only if APACHE_DISABLE_PORT_80 = false)
EXPOSE 80
# for https (apache)
#EXPOSE 443
# for postgreSQL server (only if START_POSTGRESQL = true)
#EXPOSE 5432
# for MySQL server (mariadb, only if START_MYSQL = true)
EXPOSE 3306

ADD sites/php56.conf /etc/nginx/sites-enabled/php56.conf
ADD sites/php70.conf /etc/nginx/sites-enabled/php70.conf
ADD sites/php71.conf /etc/nginx/sites-enabled/php71.conf
ADD info.php /var/www/shop/info.php

# start servers
ADD startServers.sh /usr/sbin/start-servers
ADD setupMysqlUser.sh /usr/sbin/setup-mysql-user
#ENV START_APACHE true
#ENV APACHE_ENABLE_PORT_80 false
ENV START_NGINX true
ENV START_MYSQL true
ENV START_CHROMEDRIVER true
#ENV START_POSTGRESQL false
#ENV ENABLE_DAV false
#ENV ENABLE_CRON true
CMD start-servers; setup-mysql-user; sleep infinity
