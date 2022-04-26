#!/bin/bash

if "$1" = "relabel"
	then
	echo "after relabel in order to add DE to allowed policy launch command this program with parametr allow-de"
	sudo fixfiles –F onboot
	sudo grep -rl 'SELINUX=enforcing' /etc/selinux/config | sudo xargs sed -i 's/SELINUX=enforcing/SELINUX=permissive/g'
	sudo grep -rl 'SELINUX=disabled' /etc/selinux/config | sudo xargs sed -i 's/SELINUX=disabled/SELINUX=permissive/g'
elif "$1"  = "allow_de"
	sudo allow2audit -a -M allow_de
	sudo semodule -i allow_de.pp
	mkdir /home/$user/selinux_policy
	mv ./allow_de.* /home/$user/selinux_policy 



##some question about auto relabel and enabling DE

##sudo cp /var/log/audit/audit.log /var/log/audit/audit.log.old

##sudo setenforce 0

echo "Open app/s that are not working because of SELinux"

date=$(date +"%Hh-%Mm-%Ss-%dd-%mm-%yy")

read -p "When opened all needed apps, enter name of your chosen policy for these rules"$'\n' answer

answer="$answer-$date"
echo "$answer"


