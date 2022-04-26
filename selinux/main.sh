#!/bin/bash

if  [ "$1" = "relabel" ]; then
	echo "after relabel in order to add DE to allowed policy launch command this program with parametr allow-de"
	echo "but now - reboot"
	sudo fixfiles onboot
	sudo grep -rl 'SELINUX=enforcing' /etc/selinux/config | sudo xargs sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' ##Have to find the way to silence them if there is no needed value
	sudo grep -rl 'SELINUX=disabled' /etc/selinux/config | sudo xargs sed -i 's/SELINUX=disabled/SELINUX=permissive/g'
elif [ "$1" = "allow-de" ]; then
	sudo audit2allow -a -M allow_de
	sudo semodule -i allow_de.pp
	mkdir /home/$USER/selinux_policy
	mv ./allow_de.* /home/$USER/selinux_policy 

elif [ "$1" = "allow-app" ]; then	

	sudo cp /var/log/audit/audit.log /var/log/audit/audit.log.old

	sudo setenforce 0

	echo "Open app/s that are not working because of SELinux"

	date=$(date +"%Hh-%Mm-%Ss-%dd-%mm-%yy")

	read -p "When opened all needed apps, enter name of your chosen policy for these rules"$'\n' answer

	answer="$answer-$date"

	mkdir /home/$USER/selinux_policy

	sudo awk 'NR==FNR{a[$0];next}!($0 in a)' /var/log/audit/audit.log.old /var/log/audit/audit.log > /home/$USER/selinux_policy/temp_audit_log.txt
	sudo mv /home/$USER/selinux_policy/temp_audit_log.txt /var/log/audit/audit.log 
	sudo chown root:root /var/log/audit/audit.log
	sudo chmod 0640 /var/log/audit/audit.log

	sudo audit2allow -a -M "$answer"

	sudo semodule -i "$answer.pp"
	mv ./allow_de.* /home/$USER/selinux_policy 

elif [ "$1" = "enable-enforce" ]; then 
	sudo setenforce 1 && echo "enforce mode enabled until reboot"

elif [ "$1" = "enable-enforce-perm" ]; then
	echo "Do you really know what you are going to do?"
##check for answers from the firewalld check
	
	sudo grep -rl 'SELINUX=permissive' /etc/selinux/config | sudo xargs sed -i 's/SELINUX=permissive/SELINUX=enforcing/g'
	sudo grep -rl 'SELINUX=disabled' /etc/selinux/config | sudo xargs sed -i 's/SELINUX=disabled/SELINUX=enforcing/g'
elif [ "$1" = "dog" ]; then 
	echo "woof"
else 
	echo "Wrong input try again"
fi







