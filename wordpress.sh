#!bin/bash
sudo apt update
sudo apt -y install nginx
sudo systemctl enable  nginx.service
sudo apt -y install php7.4 php7.4-gd php7.4-mysql php7.4-zip php7.4-fpm
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
sudo cp -r wordpress/* /var/www/html
sudo chown -R www-data:www-data /var/www/html
cat >/etc/nginx/sites-available/wordpress.conf <<'EOL'
server {
        listen 80;
        root /var/www/html;
        index index.php index.html index.htm index.nginx-debian.html;
       # server_name wordpress-nginx-conf;

        location = /favicon.ico { log_not_found off; access_log off; }
        location = /robots.txt { log_not_found off; access_log off; allow all; }
        location ~* \.(css|gif|ico|jpeg|jpg|js|png)$ {
             expires max;
             log_not_found off;
        }

        location / {

                try_files $uri $uri/ /index.php$is_args$args;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        }

        #location ~ /\.ht {
         #       deny all;
        #}
}
EOL
#sudo cp -r wordpress.conf /etc/nginx/sites-available/wordpress.conf

sudo ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/
sudo unlink /etc/nginx/sites-enabled/default
sudo apt update
sudo systemctl reload nginx
sudo systemctl restart nginx.service php7.4-fpm
