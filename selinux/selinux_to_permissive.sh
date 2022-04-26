!#/bin/bash



grep -rl 'SELINUX=enforcing' ./ | xargs sed -i 's/SELINUX=enforcing/SELINUX=permissive/g'
grep -rl 'SELINUX=disabled' ./ | xargs sed -i 's/SELINUX=disabled/SELINUX=permissive/g'
