#!/usr/bin/env bash
set -eu -o pipefail
[ "$START_NGINX" = true ] && nohup /usr/sbin/nginx&
[ "$START_CHROMEDRIVER" = true ] && nohup /usr/local/bin/chromedriver --url-base=/wd/hub&
[ "$START_MYSQL" = true ] && cd /usr && /usr/bin/mysqld_safe --datadir=/var/lib/mysql&
[ "$START_MYSQL" = true ] && sleep 1 && nohup /usr/bin/mysqld '--basedir=/usr' '--datadir=/var/lib/mysql' '--plugin-dir=/usr/lib64/mysql/plugin' '--user=mysql' '--log-error=/var/lib/mysql/log.err' '--socket=/run/mysqld/mysqld.sock' '--port=3306'&
