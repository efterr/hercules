#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Must run as root"
	exit 1
fi
apt-get install openssh-server -y

PORT_NUMBER="63363"
if [ ! -f /etc/ssh/sshd_config ]; then
	echo "404:File not found"
	exit 1
fi

cp /etc/ssh/sshd_config /etc/ssh/sshd_config_BACKUP

sed -i "s/^#\? \?Port .*/Port $PORT_NUMBER/g" /etc/ssh/sshd_config

systemctl enable ssh

systemctl start ssh

service sshd restart
