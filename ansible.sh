#!/usr/bin/env bash
sudo apt-get -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
apt-get update
apt-get -y install ansible sshpass

#soft-link hosts en cfg file
sudo cp -r /vagrant/. /etc/ansible

KNOW_HOSTS_FILE="/home/vagrant/.ssh/known_hosts"

chmod -x /etc/ansible/hosts

echo $KNOW_HOSTS_FILE

sudo rm $KNOW_HOSTS_FILE

cat >> etc/hosts <<EOL
#vagrant environment nodes
192.168.2.2 www1
192.168.2.4 www2
192.168.2.5 lb
192.168.2.6 mgr
EOL

ssh-keyscan 192.168.2.2 >> $KNOW_HOSTS_FILE 
ssh-keyscan 192.168.2.4 >> $KNOW_HOSTS_FILE
ssh-keyscan 192.168.2.5 >> $KNOW_HOSTS_FILE
ssh-keyscan 192.168.2.6 >> $KNOW_HOSTS_FILE
ssh-keyscan localhost >> $KNOW_HOSTS_FILE 
chown vagrant:vagrant $KNOW_HOSTS_FILE