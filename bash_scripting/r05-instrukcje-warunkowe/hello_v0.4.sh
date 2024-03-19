#!/bin/bash
# Task: Użycie instrukcji warunkowej z wieloma parametrami

if [ ! -z $1 ] && [ $# -eq 1 ] ; then
        echo "Hello $1!"
else
        echo -n "Podałeś złą ilość parametrów! "
	read -p "Podaj imię: " imie
        echo "Hello $imie!"
fi

exit 0

