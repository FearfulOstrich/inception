# Load debien buster image.
FROM debian:buster

# Update package manager
RUN apt-get update
RUN apt-get upgrade -y

# Install nginx.
RUN apt-get install -y nginx

# Copy config file.
COPY conf/inception.conf /etc/nginx/sites-available
RUN ln /etc/nginx/sites-available/inception.conf /etc/nginx/sites-enabled/inception.conf

# Setup SSL certificates.
RUN mkdir -p /etc/nginx/ssl
RUN apt-get install -y openssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=aalleon.42.fr/UID=aalleon"

# Prepare wordpress directory.
RUN mkdir -p /var/www/wordpress
RUN chmod 755 /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

# Redirect nginx log files to stdout and stderr.
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log
# Run NGINX.
CMD [ "nginx", "-g", "daemon off;" ] 
