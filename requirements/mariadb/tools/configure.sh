#!/bin/sh
#The path /run/mysqld typically refers to a directory where MySQL (or MariaDB) stores its Unix socket file and sometimes other temporary files related to its operatio
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

# check path of mysql database where it stores its data, if it does not exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
	
	chown -R mysql:mysql /var/lib/mysql

	# init database
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
		return 1
	fi

	# https://stackoverflow.com/questions/10299148/mysql-error-1045-28000-access-denied-for-user-billlocalhost-using-passw
	cat << EOF > $tfile


# Create the database
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE $WP_DATABASE_NAME;

# Create the user
CREATE USER '$WP_DATABASE_USR'@'%' IDENTIFIED BY '$WP_DATABASE_PWD';

# Grant all privileges on the database to the user
GRANT ALL PRIVILEGES ON $WP_DATABASE_NAME.* TO '$WP_DATABASE_USR'@'%';

# Make the changes take effect
FLUSH PRIVILEGES;

EOF

	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 < $tfile
	rm -f $tfile
fi


sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec /usr/bin/mysqld --user=mysql --console