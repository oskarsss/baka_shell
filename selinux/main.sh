#!/bin/bash

##some question about auto relabel and enabling DE

##sudo cp /var/log/audit/audit.log /var/log/audit/audit.log.old

##sudo setenforce 0

echo "Open app/s that are not working because of SELinux"

date=$(date +"%Hh-%Mm-%Ss-%dd-%mm-%yy")

read -p "When opened all needed apps, enter name of your chosen policy for these rules"$'\n' answer

answer="$answer-$date"
echo "$answer"


