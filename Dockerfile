
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

#Update & Upgrade
RUN apt-get update
RUN apt-get -y install apt-utils
RUN apt-get -y dist-upgrade
#install dependencies

RUN apt-get -y install git wget curl

#copy laravel conf

COPY laravel.conf /etc/apache2/sites-available/laravel.conf
#run the script
RUN apt-get -y install unzip php libapache2-mod-php php-common php-cli php-mongodb php-pear php-dev php-mbstring php-zip nano
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN pecl install mongodb
RUN echo "extension=mongodb.so" >> /etc/php/7.2/apache2/php.ini
RUN composer create-project laravel/laravel /var/www/html/laravel --prefer-dist
RUN chown -R www-data:www-data /var/www/html/laravel
RUN chmod -R 755 /var/www/html/laravel
RUN a2dissite 000-default.conf
RUN a2ensite laravel.conf
RUN a2enmod rewrite
RUN service apache2 restart
RUN service apache2 start

EXPOSE 80
EXPOSE 443

CMD tail -f /dev/null