# Use a base image with minimal OS, such as Alpine Linux
FROM alpine:latest

# Install MariaDB
RUN apk update && \
    apk add --no-cache mariadb mariadb-client mariadb-server-utils

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# Expose port 3306 for MariaDB
EXPOSE 3306

# Set the working directory
WORKDIR /var/lib/mysql

# Initialize MariaDB data directory
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start MariaDB server
CMD ["mysqld", "--user=mysql"]
