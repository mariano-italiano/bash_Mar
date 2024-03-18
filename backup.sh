#!/bin/bash

# Autor: MArcin K.
# Data: 18.03.2024
# Wersja: v1.0
#
# Changelog
# - 01.03.2024 - stworzenie skryptu, MArcin Kujawski
# - 03.03.2024 - dodano komunikat dla użytkownika  , Piotr Lewsandwoski

#read -p "Podaj nazwę pliku logu [$HOME/backup_$(date +"%d%m%Y_%H%M").log]: " LOGFILE
#read -p "Podaj co chcesz backupować[/usr/bin/*]: " BACKUP_LOC
#read -p "Podaj lokalizacje backupu[$HOME/backup]: " BACKUP_TARGET

while getopts "f:s:d:" flaga 
do 
	case "${flaga}" in 
		f) LOGFILE=${OPTARG};; 
		s) BACKUP_LOC=${OPTARG};;
		d) BACKUP_TARGET=${OPTARG};; 
	esac 
done

if [[ -z $LOGFILE || -z $BACKUP_LOC || -z BACKUP_TARGET ]] ; then
	echo "Użycie skryptu:" 
	echo " $0 -f <logfile> -s <backup-src> -d <backup-dst>"
	echo 
	exit 0
fi 

# Funkcja usuwanie pliku logu oraz 
function cleanup {
	if [[ -e $BACKUP_TARGET ]]; then
		read -n1 -p "Katalog $BACKUP_TARGET istnieje, czy chcesz kontynuować? [y/n] " DECYZJA
		if [[ $DECYZJA = "n" || $DECYZJA = "N" ]] ; then
			echo
			echo "Przerywam działanie skryptu..."
			exit 1
		else
			sudo rm -rf $BACKUP_TARGET
			echo
			echo "Usunięto katalog $BACKUP_TARGET"
		fi
	else
		echo "Nie ma katalogu $BACKUP_TARGET, usuwanie pominiete"
	fi
	if [[ -e $LOGFILE ]]; then
		sudo rm $LOGFILE
		echo "Usunięto plik $LOGFILE"
	else
		echo "Usuwanie pliku logu pominięte"
	fi
}

function createDir {
	mkdir $BACKUP_TARGET 2>/dev/null
	RC_BD=$?

}

cleanup 

createDir

cp -rp $BACKUP_LOC $BACKUP_TARGET > $LOGFILE 2>&1
RC_CP=$?

echo
if [ $RC_BD -eq 0 ] ; then
	echo -e "Tworzenie katalogu 'backup' \t\t\t[ \033[32mSUCCESS\033[0m ]"
else 
	echo -e "Tworzenie katalogu 'backup' \t\t\t[ \033[31mFAILED\033[0m  ]"
fi

if [ $RC_CP -eq 0 ] ; then
        echo -e "Kopiowanie plików \t\t\t\t[ \033[32mSUCCESS\033[0m ]"
else
        echo -e "Kopiowanie plików \t\t\t\t[ \033[31mFAILED\033[0m  ]"
fi
echo

exit 0
