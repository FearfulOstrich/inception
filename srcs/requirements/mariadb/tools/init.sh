#!/bin/bash

# Start mysql service.
service mysql start
sleep 1

# Create db.
mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

# Create new user.
mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@localhost IDENTIFIED BY '${SQL_PASSWORD}';"

# Change user rights.
mysql -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Update rights.
mysqladmin -u root -p$SQL_ROOT_PASSWORD flush-privileges

# Restart mysql.
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Start mysql_safe
echo "executing $@"
exec "$@" 
