# Load debien buster image.
FROM debian:buster

# Update package manager.
RUN apt-get update
RUN apt-get upgrade -y

# Install wget.
RUN apt-get install -y wget

# Install PHP.
RUN apt-get install -y php7.3 php-fpm php-mysql mariadb-client
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/

# Install wp cli.
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Run config script.
COPY tools/init.sh /
WORKDIR /var/www/wordpress

ENTRYPOINT [ "/init.sh" ]
CMD [ "/usr/sbin/php-fpm7.3", "-F" ]
