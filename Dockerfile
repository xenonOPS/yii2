FROM php:7.1.25-fpm-jessie
RUN docker-php-ext-install pdo_mysql && apt-get update && apt-get install nginx -y && rm /var/cache/apt/ -rf
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd
ENV DB_USER DB_HOST DB_NAME DB_PASS RUN_SERVICE
ADD nginx.conf /etc/nginx/sites-enabled/default
ADD . /var/www/html/
RUN chown www-data:www-data /var/www/html/ -R && chmod 777 /var/www/html/entrypoint.sh 

# ENTRYPOINT [ "/var/www/data/entrypoint.sh" ]
# CMD [ "php-fpm" ]
