#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Użycie kolorów w echo

while getopts "f:s:d:" flaga
  do
    case "${flaga}" in
      f) LOGFILE=${OPTARG};;
      s) BACKUP_LOC=${OPTARG};;
      d) BACKUP_TARGET=${OPTARG};;
    esac
  done


function init {
    echo "Tworzenie katalogu backup" && mkdir $BACKUP_TARGET 2>/dev/null || echo "Katalog już istnieje"
    echo "$(date +"%d/%m/%y %r %Z")" >> $LOGFILE
}

init

echo "Kopiowanie plików... " && cp -rpv $BACKUP_LOC $BACKUP_TARGET >> $LOGFILE 2>&1

grep -i denied $LOGFILE | tail -n 1

echo -e "\033[32mBackup zakończony sukcesem!\033[0m"

exit 0
