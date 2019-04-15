# See https://github.com/docker-library/php/blob/master/7.1/fpm/Dockerfile
FROM php:7.1-fpm
ARG TIMEZONE

MAINTAINER TOCHAP NGASSAM Lionel <tochlion@yahoo.fr>

RUN apt-get update && apt-get install -y \
    openssl \
    git \
    unzip \
    install php7.2-zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
&& composer --version

# Set timezone
#RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone \
#&& printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini \
#&& "date"

# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-install pdo pdo_mysql


# install xdebug
RUN pecl install xdebug \
&& docker-php-ext-enable xdebug \
&& echo "error_reporting = E_ALL" >> /etc/php/7.2/cli/conf.d/docker-php-ext-xdebug.ini \
&& echo "display_startup_errors = On" >> /etc/php/7.2/cli/conf.d/docker-php-ext-xdebug.ini \
&& echo "display_errors = On" >> /etc/php/7.2/cli/conf.d/docker-php-ext-xdebug.ini \
&& echo "xdebug.remote_enable=1" >> /etc/php/7.2/cli/conf.d/docker-php-ext-xdebug.ini \
&& echo "xdebug.remote_connect_back=1" >> /etc/php/7.2/cli/conf.d/docker-php-ext-xdebug.ini \
&& echo "xdebug.idekey=\"PHPSTORM\"" >> /etc/php/7.2/cli/conf.d/docker-php-ext-xdebug.ini \
&& echo "xdebug.remote_port=9001" >> /etc/php/7.2/cli/conf.d/docker-php-ext-xdebug.ini


RUN echo 'alias sf="php app/console"' >> ~/.bashrc \
&& echo 'alias sf3="php bin/console"' >> ~/.bashrc

RUN mkdir -pv /home/symfony-kubectl-deploy
ADD . /home/symfony-kubectl-deploy
EXPOSE 8000

WORKDIR /home/symfony-kubectl-deploy

RUN composer install
CMD php -S 0.0.0.0:8000 -t ./public

