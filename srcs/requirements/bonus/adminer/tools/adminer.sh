#!/bin/sh
apt-get update && apt-get install -y wget

cd /var/www/html
wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php
mv adminer-4.8.1.php adminer.php
