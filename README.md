# helpers
Scripts that would help while pentesting

## buildip.sh
This script helps you build IPs file based on a previous -sP nmap scan.

## scan_iplist.sh
This script scan all the targets inside an input file. It creates a directory for each target and write the scan result into a nmaped.txt file.

## nmap_helper.sh
This script double scan a target. First it checks for all possible opened ports in aggressive mode. Then it runs a second scan with more discovery options against the previously found ports only.
