#!/bin/sh

if [ "$#" -ne 2 ] || ! [ -f "$1" ]; then
	echo "Usage: $0 INPUT_FILE OUTPUT_FILE"
	exit 1
else
	egrep --only-matching -E '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' \
	$1 > $2 && sed -i '1d' $2
fi