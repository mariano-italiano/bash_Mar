#!/bin/bash

FILE=$1

if [[ -z $1 ]]; then
	echo
	echo "Usage: $0 <file>"
	echo
else
	if [[ -e "$FILE" ]]; then
		echo "Plik $FILE istnieje"
	else	
		echo "Plik $FILE nie istnieje"
	fi
fi
exit 0
