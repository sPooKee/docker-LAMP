#!/usr/bin/env bash
set -eu -o pipefail

apt-get update
apt-get install -y language-pack-en-base
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
apt-get install -y software-properties-common python-software-properties 
add-apt-repository -y ppa:ondrej/php
apt-get update
apt-get install -y nginx mariadb-server imagemagick
apt-get install -y php5.6 php5.6-fpm php5.6-curl php5.6-gd php5.6-iconv php5.6-mbstring php5.6-xml php5.6-imagick php5.6-zip php5.6-mysql php5.6-opcache php5.6-mcrypt php5.6-json php5.6-intl
apt-get install -y php7.0 php7.0-fpm php7.0-curl php7.0-gd php7.0-iconv php7.0-mbstring php7.0-xml php7.0-imagick php7.0-zip php7.0-mysql php7.0-opcache php7.0-mcrypt php7.0-json php7.0-intl
apt-get install -y php7.1 php7.1-fpm php7.1-curl php7.1-gd php7.1-iconv php7.1-mbstring php7.1-xml php7.1-imagick php7.1-zip php7.1-mysql php7.1-opcache php7.1-mcrypt php7.1-json php7.1-intl
apt-get install -y php-xdebug wget curl nano

wget http://jtl-url.de/shopcli-latest -O shopcli
chmod +x shopcli
mv shopcli /usr/local/bin/shopcli
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer global require codeception/codeception
export PATH=~/.config/composer/vendor/bin:$PATH

apt-get install -y unzip openjdk-8-jre-headless xvfb libxi6 libgconf-2-4
curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
apt-get update
apt-get -y install google-chrome-stable

CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`
SELENIUM_STANDALONE_VERSION=3.8.1
SELENIUM_SUBDIR=$(echo "$SELENIUM_STANDALONE_VERSION" | cut -d"." -f-2)

wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/
unzip ~/chromedriver_linux64.zip -d ~/
rm ~/chromedriver_linux64.zip
mv -f ~/chromedriver /usr/local/bin/chromedriver
chown root:root /usr/local/bin/chromedriver
chmod 0755 /usr/local/bin/chromedriver

wget -N http://selenium-release.storage.googleapis.com/$SELENIUM_SUBDIR/selenium-server-standalone-$SELENIUM_STANDALONE_VERSION.jar -P ~/
mv -f ~/selenium-server-standalone-$SELENIUM_STANDALONE_VERSION.jar /usr/local/bin/selenium-server-standalone.jar
chown root:root /usr/local/bin/selenium-server-standalone.jar
chmod 0755 /usr/local/bin/selenium-server-standalone.jar

apt-get autoremove
apt-get autoclean

echo "127.0.0.1    php56.dev php70.dev php71.dev" >> /etc/hosts
mkdir /var/www/shop
chown www-data:www-data /var/www/shop
# reduce docker layer size
#cleanup-image
