FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

#Update & Upgrade
RUN apt-get update
RUN apt-get -y install apt-utils
RUN apt-get -y dist-upgrade
#Install dependencies

RUN apt-get -y install git wget curl software-properties-common ca-certificates

#install node
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get -y install nodejs

#run the script

#RUN apt-get -y install unzip php libapache2-mod-php php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-cli php-zip php-mongodb php-pear php-xdebug php-dev php-gmp nano
RUN apt-get -y install unzip php libapache2-mod-php php-* nano
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 777 /var/www/html
RUN rm -rf /etc/apache2/sites-available/*
RUN rm -rf /etc/apache2/sites-enabled/*
RUN a2enmod rewrite
RUN service apache2 restart
COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 8000-8100
EXPOSE 80
EXPOSE 443

CMD /init.sh
