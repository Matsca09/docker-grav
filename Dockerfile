FROM nginx:latest

RUN apt update && apt install -y php5-fpm php5-cli php5-gd curl php5-curl git && apt-get clean
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN git clone https://github.com/getgrav/grav.git /var/www/grav && chown -R www-data:www-data /var/www/grav
WORKDIR /var/www/grav
USER www-data
RUN composer install --no-dev -o
RUN bin/grav install

COPY nginx.conf /etc/nginx/nginx.conf
COPY grav.conf /etc/nginx/conf.d/default.conf
COPY init.sh /init.sh

USER root
ENTRYPOINT ["/init.sh"]

