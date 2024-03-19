#!/bin/bash
# Task: Użycie instrukcji warunkowej

echo "Wykonuje skrypt o nazwie $0"

if [ ! -z $1 ] ; then             # [ $# -lt 1 ]
        echo "Hello $1!"
else
        read -p "Podaj imię: " imie
        echo "Hello $imie!"
fi

exit 0

