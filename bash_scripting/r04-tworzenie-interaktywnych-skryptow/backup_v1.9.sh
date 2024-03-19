#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Użycie read -p z wartościami defaultowymi

read -p "Podaj nazwę pliku logu [logfile.log]: " LOGFILE
read -p "Podaj folder/pliki do backupu [/usr/bin/*]: " BACKUP_LOC
read -p "Podaj lokalizacje zapisu backupu [/home/$USER/backup]: " BACKUP_TARGET

LOGFILE=${LOGFILE:-logfile.log}
BACKUP_LOC=${BACKUP_LOC:-/usr/bin/*}
BACKUP_TARGET=${BACKUP_TARGET:-/home/$USER/backup}

function init {
    echo "Tworzenie katalogu backup" && mkdir $BACKUP_TARGET 2>/dev/null || echo "Katalog już istnieje"
    echo "$(date +"%d/%m/%y %r %Z")" >> $LOGFILE
}

init

echo "Kopiowanie plików... " && cp -v $BACKUP_LOC $BACKUP_TARGET >> $LOGFILE 2>&1

grep -i denied $LOGFILE | tail -n 1

