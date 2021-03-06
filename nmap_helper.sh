#!/bin/bash

declare ports
declare ip
declare opt

ip=$1
opt=$2

mnmap () {
        echo -e "\nScanning $ports port(s)..."

        nmap -sC -sV -Pn -p $ports $ip -oN nmaped.txt \
        && echo -e "\nSuccessfully wrote result into nmaped.txt"
}

chkept () {
        [ -z "$ports" ] && echo "Nmap exited before scanning any host. Try with -Pn option."
}

parser () {
        grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//
}

scanall () {
        if ! [ -z "$opt" ]; then
                nmap -p- --min-rate=1000 -T4 $ip $opt
        else
                nmap -p- --min-rate=1000 -T4 $ip
        fi
}

if [ -z "$ip" ] || [ $# -eq 0 ]; then
        echo "USAGE: $0 [TARGET] [-Pn (optional)]"
        exit 1
fi

if [ "$opt" == "-Pn" ]; then
        echo "Trying to scan with $opt option..."
        ports=$(scanall | parser)
        if chkept; then
                exit 1
        else
                mnmap
        fi
else
        echo "Starting scan against $ip..."
        ports=$(scanall | parser)
        if chkept; then
                exit 1
        else
                mnmap
        fi
fi
