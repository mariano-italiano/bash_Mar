#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Opisy

echo "Tworzenie katalogu backup"
mkdir ~/backup
echo 'Kopiowanie plików...'
cp /usr/bin/* ~/backup

