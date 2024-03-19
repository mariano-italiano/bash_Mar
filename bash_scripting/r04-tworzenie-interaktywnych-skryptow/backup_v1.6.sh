#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Użycie 'echo -n' oraz read() 

echo -n "Podaj nazwę pliku logu: "
read
LOGFILE=$REPLY
BACKUP_LOC="/usr/bin/*"
BACKUP_TARGET="/home/$USER/backup"

function init {
    echo "Tworzenie katalogu backup" && mkdir $BACKUP_TARGET 2>/dev/null || echo "Katalog już istnieje"
    echo "$(date +"%d/%m/%y %r %Z")" >> $LOGFILE 
}

init

echo "Kopiowanie plików... " && cp -v $BACKUP_LOC $BACKUP_TARGET >> $LOGFILE 2>&1

grep -i denied $LOGFILE | tail -n 1

