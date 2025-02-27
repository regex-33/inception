#!/bin/bash
# Ensure vsftpd is installed
apt-get update && apt-get install -y vsftpd

mkdir -p /etc/vsftpd

## Create the secure_chroot_dir
mkdir -p /var/run/vsftpd/empty

if [ ! -f /etc/vsftpd/vsftpd.conf ]; then
    cat <<EOF > /etc/vsftpd/vsftpd.conf
listen=YES
listen_ipv6=NO

pasv_enable=Yes
pasv_min_port=10000
pasv_max_port=10100

anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
allow_writeable_chroot=YES
pam_service_name=vsftpd
user_sub_token=\$USER
local_root=/var/www/html

EOF
fi



adduser --disabled-password --gecos "" $FTP_USER
echo "$FTP_USER:$FTP_PASS" | chpasswd

## Add the user to the list of users allowed to use the ftp server
echo "$FTP_USER" >> /etc/vsftpd/user_list

sed -i "s|#local_root=/var/www/localhost/htdocs|local_root=/var/www/html|g" /etc/vsftpd/vsftpd.conf

chown -R $FTP_USER:$FTP_USER /var/www/html

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
