#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Zmienne użytkownika

LOGFILE="/home/$USER/log_file"
BACKUP_LOC="/usr/bin/*"
BACKUP_TARGET="/home/$USER/backup"

echo "Tworzenie katalogu backup" && mkdir $BACKUP_TARGET 2>/dev/null || echo "Katalog już istnieje"

echo "Kopiowanie plików... " && cp -v $BACKUP_LOC $BACKUP_TARGET > $LOGFILE 2>&1

grep -i denied $LOGFILE | tail -n 1

