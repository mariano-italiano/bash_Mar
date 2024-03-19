#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Przechwycenie sygnału SIGINT 

while getopts "f:s:d:" flaga
  do
    case "${flaga}" in
      f) LOGFILE=${OPTARG};;
      s) BACKUP_LOC=${OPTARG};;
      d) BACKUP_TARGET=${OPTARG};;
    esac
  done

if [ -z $LOGFILE ] || [ -z $BACKUP_LOC ] || [ -z BACKUP_TARGET ] ; then
	echo "Użycie skryptu:"
	echo " ./backup.sh -f <logfile> -s <backup-src> -d <backup-dst>"
	echo
	exit 0
else
	if [ -e $BACKUP_TARGET ] ; then
		read -p "Folder $BACKUP_TARGET już istnieje, czy chcesz kontynuować [y/n]? " decyzja
		case "$decyzja" in
			"yes" | "y") echo -e "\033[32mZgoda, lecimy dalej...\033[0m" ;;
			"no" | "n")  echo "Przerywanie działania skryptu..."
				     exit 1 ;;
			*) echo -e "\033[31mMusisz podać albo 'y' albo 'n'!\033[0m"
			   exit 1 ;;
		esac
	fi
fi

CTRLC=0

function przechwyc_SIGINT {
	CTRLC=$(( $CTRLC + 1 ))
	echo
	if [[ $CTRLC = 1 ]] ; then
		read -p "Wcisnąłeś Ctrl+C, czy chcesz zakończyć działanie programu? [y/n]: " wyjscie
		if [ $wyjscie = 'y' ] ; then
			exit		
		else
			CTRLC=0
		fi
	fi	
}

function init {
    echo "Tworzenie katalogu backup" && mkdir $BACKUP_TARGET 2>/dev/null || echo "Katalog już istnieje"
    echo "$(date +"%d/%m/%y %r %Z")" >> $LOGFILE
}

init

trap przechwyc_SIGINT SIGINT

echo "Kopiowanie plików... " && cp -rpv $BACKUP_LOC $BACKUP_TARGET >> $LOGFILE 2>&1

KOMPRESJA=""
if [ $? -eq 0 ] ; then
	echo
	echo "Backup zakończony sukcesem"
	echo
	while [ -z $KOMPRESJA ] ; do
		read -p "Czy dokonać kompresji $BACKUP_TARGET ? [y/n]: " odp
		if [ $odp = "y" ] || [ $odp = "yes" ] ; then
			KOMPRESJA=1
			echo "Kompresuje backup..."
			tar -czf $BACKUP_TARGET.tar.gz $BACKUP_TARGET/* > /dev/null 2>&1 
			
		elif [ $odp = "n" ] || [ $odp = "no" ] ; then
 	        	KOMPRESJA=0
			echo "Kompresja pominięta"
		else
			echo "Podałeś złą odpowiedź!"
		fi
	done
	echo
else 
	echo
	echo "Backup zakończony z błędami. Sprawdź plik logów: $LOGFILE, aby zobaczyć szczegóły"

fi

for i in $(find $BACKUP_TARGET -perm /u+s) ; do
	if [[ "$i" == *"su"* ]] ; then
        	continue;
	fi
	if [[ "$i" == *"mount"* ]] ; then
        	break;
	fi
	
	ls -la $i >> $BACKUP_TARGET/setuid.list
done

if [ -s $BACKUP_TARGET/setuid.list ] ; then
	echo "WAŻNE: Znaleziono pliki z niebezpiecznymi uprawnieniami setuid"
	echo "       Szczegóły znajdują sie w pliku $BACKUP_TARGET/setuid.list"	
fi
echo

exit 0
