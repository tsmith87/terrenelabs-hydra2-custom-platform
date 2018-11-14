#!/bin/bash -e

sudo service supervisor stop
sudo service supervisor start
sudo service nginx restart
echo "[Restarting Application Server]/post - Step 3."
