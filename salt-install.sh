#!/bin/bash

sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg

if [ -f "/etc/apt/sources.list.d/salt.list" ]; then
        echo "konfigurujem repo"
        echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/sources.list.d/salt.list
else
        echo "vytvaram subor najprv"
        echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/sources.list.d/salt.list
fi

apt-get -y update
apt-get install -y salt-master
apt-get install -y salt-minion

systemctl restart salt-minion

echo "backup master file"
cp /etc/salt/master /etc/salt/master_bck
cp /etc/salt/minion /etc/salt/minion_bck

sed -i "s/#interface: 0.0.0.0/interface: `ifconfig | grep inet | grep -v inet6 | grep -v 127* | awk '{print $2}'`/g" /etc/salt/master
sed -i "s/#master: salt/master: `ifconfig | grep inet | grep -v inet6 | grep -v 127* | awk '{print $2}'`/g" /etc/salt/minion

mkdir -p /srv/salt/
