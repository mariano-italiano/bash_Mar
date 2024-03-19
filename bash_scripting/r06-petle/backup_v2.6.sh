#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Użycie pętli for 

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

function init {
    echo "Tworzenie katalogu backup" && mkdir $BACKUP_TARGET 2>/dev/null || echo "Katalog już istnieje"
    echo "$(date +"%d/%m/%y %r %Z")" >> $LOGFILE
}

init

echo "Kopiowanie plików... " && cp -rpv $BACKUP_LOC $BACKUP_TARGET >> $LOGFILE 2>&1

if [ $? -eq 0 ] ; then
	echo
	echo "Backup zakończony sukcesem"
	echo
else 
	echo
	echo "Backup zakończony z błędami. Sprawdź plik logów: $LOGFILE, aby zobaczyć szczegóły"

fi

for i in $(find /tmp/test123 -perm /u+s) ; do
	ls -la $i >> $BACKUP_TARGET/setuid.list
done

if [ -s $BACKUP_TARGET/setuid.list ] ; then
	echo "WAŻNE: Znaleziono pliki z niebezpiecznymi uprawnieniami setuid"
	echo "       Szczegóły znajdują sie w pliku $BACKUP_TARGET/setuid.list"	
fi
echo

exit 0
