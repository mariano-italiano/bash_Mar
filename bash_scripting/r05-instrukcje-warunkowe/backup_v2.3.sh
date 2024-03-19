#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Użycie wielu instrukcji warunkowych

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

exit 0
