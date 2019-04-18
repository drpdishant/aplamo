
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

#Update & Upgrade
RUN apt-get update
RUN apt-get -y install apt-utils
RUN apt-get -y dist-upgrade
#install dependencies

RUN apt-get -y install git wget curl

#run the script
RUN apt-get install -y php php-{mongodb,pear,xdebug,dev,xml,xmlrpc,soap,cli,common,bcmath,bz2,intl,gd,mbstring,mcrypt,mysql,zip}
RUN apt-get -y apache2 unzip libapache2-mod-php nano

#RUN apt-get -y install unzip php libapache2-mod-php php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-cli php-zip php-mongodb php-pear php-xdebug php-dev nano

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN pecl install mongodb
RUN echo "extension=mongodb.so" >> /etc/php/7.2/apache2/php.ini
RUN a2enmod rewrite
RUN service apache2 restart
COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 80
EXPOSE 443

CMD /init.sh