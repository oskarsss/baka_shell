#!/bin/bash


sudo grep -rl 'SELINUX=enforcing' /etc/selinux/config | sudo xargs sed -i 's/SELINUX=enforcing/SELINUX=permissive/g'
sudo grep -rl 'SELINUX=disabled' /etc/selinux/config | sudo xargs sed -i 's/SELINUX=disabled/SELINUX=permissive/g'

