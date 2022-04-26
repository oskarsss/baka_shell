#!/bin/bash

source ./get_answer.sh
Firewalld_initial_setup() {
printf "Firewalld setup"
printf "Firstly we need to define, do you want to keep your zone configurations for firewalld?(this command might require root priviledges) If you don't know what it is, then answer most likely is yes - don't save."
printf "Your configurations will be saved in same place, but with *.log extension"
printf "Do you want to use default firewalld configuration?"

confirm && sudo find /etc/firewalld/zones -name "*.xml" -exec mv {} {}.log \;
#firewall-cmd --set-default-zone=public nepieciešams atrast vietu, kur šo nodefinēt
nmcli -t -f NAME connection show > connection_names.txt

printf "\nWrite numbers of connections that you want to be marked as home networks (ex. 1 5 6) \n\n "

cat -n connection_names.txt

read -r -p "${1:-Write sequence of numbers, please} " connection_numbers_string
connection_numbers=($connection_numbers_string)
#read -a connection_numbers <<< $connection_numbers_string

	declare -i i_counter
	i_counter=1
	IFS=@
	while read line;
	do
		printf "$i_counter\n"
		printf "$line\n"
		case "@${connection_numbers[*]}@" in
			(*"@$i_counter@"*)
			#nmcli connection modify profile connection.zone zone_name
			printf "Matches\n"
			;;
		(*)
			printf "Does not match\n"	
			;;
		esac

		((i_counter=i_counter+1))
	done < connection_names.txt
	rm connection_names.txt
#else 
#	while read line;
 #       do
#		printf "$line and stuff\n"
	#	nmcli connection modify $line connection.zone public
#	done < connection_names.txt
#	rm connection_names.txt
}
