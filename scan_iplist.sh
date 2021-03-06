#!/bin/sh

if [ "$#" -ne 1 ] || ! [ -f "$1" ]; then
	echo "Usage: $0 INPUT_FILE"
	exit 1
else
	while IFS="" read -r ip || [ -n "$ip" ]
	do
		echo "Handling $ip..."
		echo
		mkdir $ip
		echo "$ip directory created"
		ports=$(nmap -p- --min-rate=1000 -T4 $ip | grep ^[0-9] | cut -d '/' -f 1 | \
		tr '\n' ',' | sed s/,$//)
		echo "Scanning $ports port(s) from $ip in progress..."
		echo && nmap -Pn -sV -sC -p $ports $ip -oN $ip/nmaped.txt > /dev/null
		echo "$ip scan terminated"
		echo
		echo "----------------------------"
	done < $1
fi
