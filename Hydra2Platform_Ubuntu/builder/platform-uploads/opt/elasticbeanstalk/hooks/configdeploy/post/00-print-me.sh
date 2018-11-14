#!/bin/sh

sudo rm -rf /tmp/hydra2.conf
sudo rm -rf /tmp/var.txt
sed -n '/^environment=/q;p' /etc/supervisor/conf.d/hydra2.conf > /tmp/hydra2.conf
echo "environment=" >> /tmp/hydra2.conf
sudo /opt/elasticbeanstalk/bin/get-config environment --output yaml | sed -n '1!p' | sed -e 's/^\(.*\): /\1=/g' > /tmp/var.txt
sed '$!s/$/,/' /tmp/var.txt
cat /tmp/var.txt | while read LINE; do echo $'\t'$LINE >> /tmp/hydra2.conf; done;
sudo cp -f /tmp/hydra2.conf /etc/supervisor/conf.d/hydra2.conf
sudo supervisorctl reread
sudo service supervisor stop
sudo service supervisor start
echo "[Configuration Deployment] Executed when starting configuration deployment"
