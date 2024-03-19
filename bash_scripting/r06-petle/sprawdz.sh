#!/bin/bash
# Skrypt sprawdzający czy obiekt jest plikiem czy katalogiem
# Task: Użycie pętli zagnieżdżonej for

if [ -z $1 ] ; then
	echo
	echo "Użycie: ./sprawdz.sh <sciezka>"
	echo
	exit 1
fi 

for sciezka in $1/* ; do
        if [ -d "$sciezka" ] ; then
                echo "$sciezka jest folderem"
                for sciezka2 in $sciezka/* ; do
                        if [ -d "$sciezka2" ] ; then
                                echo "$sciezka2 jest folderem"
                        elif [ -f "$sciezka2" ] ; then
                                echo "$sciezka2 jest plikiem"
                        fi
                done
        elif [ -f "$sciezka" ] ; then
                echo "$sciezka jest plikiem"
        fi
done
echo
exit 0

