#!/bin/bash

if [ $# -eq 2 ] ; then
	IMIE=$1
	WIEK=$2
else
	# Wyswietlenie usage dla skryptu 
	echo "Usage: $0 <imie> <wiek>"
	exit 1
fi

echo "Imie to: $IMIE"
echo "Wiek to: $WIEK"
exit 0
