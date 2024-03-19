#!/bin/bash
# Data: 01.01.2023
# Autor: Marcin Kujawski
# Opis: Skrypt monitorujący liczbe użytkowników na systemie
# Użycie: ./lab4.sh -f <logfile>
#

# Wczytanie argumentu skryptu
while getopts "f:s:d:" flaga
  do
    case "${flaga}" in
      f) LOGFILE=${OPTARG};;
    esac
  done

if [ -z $LOGFILE ] ; then
        echo "Użycie skryptu:"
        echo " ./lab4.sh -f <logfile>"
        echo
        exit 0
fi

# Przychwycenie SIGINT
CTRLC=0
KILL=0

function przechwyc_SIGINT {
        CTRLC=$(( $CTRLC + 1 ))
        if [[ $CTRLC > 0 ]] ; then
                echo "`date +'%m-%d-%Y %H:%M:%S'` - INFO - Przechwycony sygnał SIGINT" >> /tmp/$LOGFILE
        fi
}

# Przechwycenie SIGKILL 
function przechwyc_SIGTERM {
        KILL=$(( $KILL + 1 ))
        if [[ $KILL > 0 ]] ; then
                echo "`date +'%m-%d-%Y %H:%M:%S'` - INFO - Przechwycony sygnał SIGKILL" >> /tmp/$LOGFILE
        fi
}

# Przechwycenie sygnałów
trap przechwyc_SIGINT SIGINT
trap przechwyc_SIGTERM SIGTERM

# Clean log file
rm -f /tmp/$LOGFILE
touch /tmp/$LOGFILE

# Sprawdzanie użytkowników
while true
do
	
	ALL_USERS=`who | wc -l`
	ROOT=`who | grep -i root | wc -l`

	if [[ $ALL_USERS > 0 ]] ; then
		echo "`date +'%m-%d-%Y %H:%M:%S'` - INFO - Liczba zalogowanych użytkwników na systemie: $ALL_USERS" >> /tmp/$LOGFILE
	fi

	if [[ $ROOT > 0 ]] ; then
		echo "`date +'%m-%d-%Y %H:%M:%S'` - WARN - Użytkownik root jest zalogowany" >> /tmp/$LOGFILE
	fi
	sleep 60

done

exit 0
