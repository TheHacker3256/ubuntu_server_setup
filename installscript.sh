#!/bin/bash

#update
sudo apt update

#apache install
echo "install apache 2"
read apache2

if [ "$apache2" = "y" ];
then
sudo apt install apache2 \
                 ghostscript \
                 mysql-server -y


fi

#wordpress install
echo "install wordpress"
read wordpress

if [ "$wordpress" = "y" ];
then
echo "paste wordpress installation here"

fi

#nextcloud install
echo "install nextcloud"
read nextcloud

if [ "$nextcloud" = "y" ];
then
sudo apt install php7.4 php7.4-gd php7.4-sqlite3 php7.4-curl php7.4-zip php7.4-xml php7.4-mbstring php7.4-mysql php7.4-bz2 php7.4-intl php-smbclient php7.4-imap php7.4-gmp php7.4-bcmath php7.4-imagick libapache2-mod-php7.4
sudo systemctl restart apache2

sudo a2enmod rewrite
sudo a2enmod env
sudo a2enmod headers
sudo a2enmod dir
sudo a2enmod mime

cd /var/www/
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2
sudo tar -xvf latest.tar.bz2
sudo mkdir -p /var/www/nextcloud/data
sudo chown -R www-data:www-data /var/www/nextcloud
sudo chmod 750 /var/www/nextcloud/data
sudo nano /etc/php/7.4/apache2/php.ini

mv ./nextcloud.conf /etc/apache2/sites-available
sudo a2ensite nextcloud.conf
sudo systemctl reload apache2

fi

#docker  install
echo "install docker"
read docker

if [ "$docker" = "y" ];
then
sudo apt install docker.io -y
echo "install heimdall"
read heimdall

fi
#heimdall install
if [ "$heimdall" = "y" ];
then
sudo docker volume create heimdall
sudo docker run \
--name=heimdall \
-e PUID=1000 \
-e PGID=1000 \
-e TZ=america/new_york \
-p 8006:80 \
-p 406:433 \
-v heimdall:/config \
--restart unless-stopped \
-d \
linuxserver/heimdall

fi

#portainer install
echo "install portainer"
read portainer

if [ "$portainer" = "y" ];
then
sudo docker run -d -p 9000:9000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

fi

#jellyfin install
echo "install jellyfin"
read jellyfin

if [ "$jellyfin" = "y" ];
then
curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash

fi