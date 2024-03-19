#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Zmienne lokalne

LOGFILE=$1
BACKUP_LOC="/usr/bin/*"
BACKUP_TARGET="/home/$USER/backup"

function init {
    echo "Tworzenie katalogu backup" && mkdir $BACKUP_TARGET 2>/dev/null || echo "Katalog już istnieje"
    echo "" > $LOGFILE
    local VAR1=30
    VAR2=10
}

init

echo "Kopiowanie plików... " && cp -v $BACKUP_LOC $BACKUP_TARGET >> $LOGFILE 2>&1

grep -i denied $LOGFILE | tail -n 1
echo $VAR1
echo $VAR2

