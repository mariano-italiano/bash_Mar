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
		case  "$DECYZJA" in
			"yes" | "y") sudo rm -rf $BACKUP_TARGET
				     sudo rm -rf $BACKUP_TARGET.tar.gz
				     echo
				     echo "Usunięto katalog $BACKUP_TARGET"
				     ;;
			"no" | "n")  echo
				     echo "Przerywam działanie skryptu..."
				     exit 1
				     ;;
			*) 	     echo 
			    	     echo "Podałeś złą odpowiedź, musisz podać 'y' lub 'n' !!!"
				     exit 1
				     ;;
		esac
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

for plik in $(find $BACKUP_LOC -perm /u+s | sort)
do
	if [[ $plik == *"ch"* ]] ; then
		#echo "jestem w su"
		continue;
	fi
	if [[ $plik == *"mount"* ]] ; then
		#echo "jestem w mount"
		break;
	fi
	ls -la $plik >> $BACKUP_TARGET/setuid.list
done

if [[ -e $BACKUP_TARGET/setuid.list ]]; then
	echo "UWAGA: Znaleziono pliki z niebezpiecznymi uprawnieniami. Szczególy w '$BACKUP_TARGET/setuid.list'"
fi

cp -rp $BACKUP_LOC $BACKUP_TARGET > $LOGFILE 2>&1
RC_CP=$?

COMPRESSION=""
while [ -z $COMPRESSION ] ; do
	read -n 1 -p "Czy dokonać kompresji katalogu $BACKUP_TARGET ? [y/n] " ANSWER
	if [[ $ANSWER = "y" ]] ; then
		COMPRESSION=1
		echo
		echo "Kompresuje pliki backupu..."
		tar -czf $BACKUP_TARGET.tar.gz $BACKUP_TARGET/* > /dev/null 2>&1
	elif [[ $ANSWER = "n" ]] ; then
		COMPRESSION=0
		echo
		echo "Kompresja plików pominięta"
	else
		echo
		echo "Podano złą odpowiedź!"
	fi
done

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
