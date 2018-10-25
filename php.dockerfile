FROM php:7-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev mysql-client netcat git zip unzip \
    && pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt && docker-php-ext-install pdo_mysql

COPY ./conf/php/init.sh /home/init.sh

RUN sed -i -e 's/\r$//' /home/init.sh

RUN chmod +x /home/init.sh

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

ENTRYPOINT ["/home/init.sh"]
CMD ["-S", "0.0.0.0:80", "-t", "./public", "./public/index.php"]

WORKDIR /var/www
