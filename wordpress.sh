sudo apt update
sudo apt install nginx
sudo systemctl status nginx.service
sudo systemctl enable  nginx.service
sudo apt install php7.4 php7.4-gd php7.4-mysql php7.4-zip php7.4-fpm
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
sudo cp -r wordpress/* /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo sed -i 's/index.html/index.php/' /etc/nginx/sites-available/default
sudo sed -i 's/=404/index.php?$args/' /etc/nginx/sites-available/default
sudo sed -i 's/server/#/' /etc/nginx/sites-available/default
sudo tee -a /etc/nginx/sites-available/default > /dev/null <<EOT 
location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
}
EOT
sudo systemctl restart nginx.service php7.4-fpm
