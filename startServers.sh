#!/usr/bin/env bash
set -eu -o pipefail
[ "$START_NGINX" = true ] && service php5.6-fpm start
[ "$START_NGINX" = true ] && service php7.0-fpm start
[ "$START_NGINX" = true ] && service php7.1-fpm start
[ "$START_NGINX" = true ] && service nginx start
[ "$START_MYSQL" = true ] && service mysql start
[ "$START_CHROMEDRIVER" = true ] && nohup /usr/local/bin/chromedriver --url-base=/wd/hub&
