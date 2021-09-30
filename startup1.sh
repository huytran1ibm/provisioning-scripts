#!/bin/bash
host=$(cat /etc/hostname)
wget https://4849-2600-1700-5030-4e90-c4d4-3b79-e7c0-b7d8.ngrok.io/hihuy/${host}

indexhtml=/var/www/html/index.nginx-debian.html

# wait for the cloud-init boot process to complete
until [ -f /$indexhtml ]; do
  date
  sleep 11
done

# initial value
thishost=$(cat /etc/hostname)
cat > $indexhtml <<EOF
INIT - ${thishost}
EOF

# Internet is availble then more software can be installed from the internet like
# npm, pip, docker, ...  if isolated only the software from the ibm mirrors can be installed
if curl -o /tmp/x https://www.python.org/downloads/release/python-373/; then
cat > $indexhtml <<EOF
INTERNET - ${thishost}
EOF
else
cat > $indexhtml <<EOF
ISOLATED - ${thishost}
EOF
fi
