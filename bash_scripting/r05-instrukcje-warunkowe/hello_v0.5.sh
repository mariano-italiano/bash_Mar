#!/bin/bash
# Task: Użycie zagnieżdżonej instrukcji warunkowej

if [ $# -eq 1 ] ; then
	echo "Hello $1!"
else
	if [ $# -gt 1 ] ; then
	        echo "Podałeś za dużo parametrów!"
	fi

	if [ $# -lt 1 ] ; then
	        echo "Podałeś za mało parametrów!"
	fi

	read -p "Podaj imię: " imie
        echo "Hello $imie!"
fi

exit 0

