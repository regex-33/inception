openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=MO/L=BG/O=1337/OU=student/CN=youssef.42.ma"

echo '

' >  /etc/nginx/nginx.conf

exec "nginx -g 'daemon off;'"