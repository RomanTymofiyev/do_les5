#!/usr/bin/env bash
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible sshpass

ln -sf /vagrant/hosts /etc/ansible/hosts
ln -sf /vagrant/examples/* /etc/ansible/

KNOW_HOSTS_FILE="/home/vagrant/.ssh/known_hosts"

[ -f "$KNOW_HOSTS_FILE" ] && rm $KNOW_HOSTS_FILE 

ssh-keyscan 10.0.15.11 >> $KNOW_HOSTS_FILE 
ssh-keyscan 10.0.15.21 >> $KNOW_HOSTS_FILE
ssh-keyscan 10.0.15.22 >> $KNOW_HOSTS_FILE
ssh-keyscan 10.0.15.10 >> $KNOW_HOSTS_FILE
chown vagrant:vagrant $KNOW_HOSTS_FILE 

# TODO: ssh-keyscan can be replaced if a playbook is created that copies the
# files, ssh-agent needs to be implemented as wel.
