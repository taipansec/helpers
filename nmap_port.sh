#!/bin/bash

declare ports
declare ip

ip=$1

mnmap () {
	nmap -sC -sV -Pn -p $ports $ip -oN nmaped.txt \
	&& echo -e "\nSuccessfully wrote result into nmaped.txt"
}

chkept () {
	[ -z "$ports" ] && echo "Nmap exited before scanning any host. Try with -Pn option."
}

if [ -z "$ip" ] || [ $# -eq 0 ]; then
	echo "USAGE: $0 [TARGET] [-Pn (optional)]"
	exit 1
elif [ "$2" == "-Pn" ]; then
	echo "Trying to scan with $2 option..."
	ports=$(nmap -p- --min-rate=1000 -T4 $ip $2 | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)
	if chkept; then
		exit 1
	else
		echo "Scanning $ports port(s)"
		mnmap
	fi
else
	ports=$(nmap -p- --min-rate=1000 -T4 $ip | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)
	if chkept; then
		exit 1
	else
		echo "Scanning $ports port(s)"
		mnmap
	fi
fi