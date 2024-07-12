## Ensure vsftpd is installed
apt-get update && apt-get install -y vsftpd
# apt install iptables


## Create necessary directories
mkdir -p /etc/vsftpd

## Create the secure_chroot_dir
mkdir -p /var/run/vsftpd/empty

## Check if vsftpd.conf exists, if not create it
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


# iptables -A INPUT -p tcp --match multiport --dports 10000:10100 -j ACCEPT
# iptables -A INPUT -p tcp --match multiport --dports 21 -j ACCEPT


## Create a user for ftp access (adjusted for non-Alpine Linux distributions)
adduser --disabled-password --gecos "" $FTP_USER
echo "$FTP_USER:$FTP_PASS" | chpasswd

## Add the user to the list of users allowed to use the ftp server
echo "$FTP_USER" >> /etc/vsftpd/user_list

## Set the home directory for the user in vsftpd.conf correctly
sed -i "s|#local_root=/var/www/localhost/htdocs|local_root=/var/www/html|g" /etc/vsftpd/vsftpd.conf

## Create a directory for the user and set ownership
# mkdir -p /var/www/html
chown -R $FTP_USER:$FTP_USER /var/www/html

## Start the ftp server
exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf