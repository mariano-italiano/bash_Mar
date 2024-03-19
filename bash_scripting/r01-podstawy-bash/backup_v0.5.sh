#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Jeden argument skryptu

echo "Tworzenie katalogu backup" && mkdir ~/backup || echo "Katalog już istnieje"
echo "Kopiowanie plików... " && cp /usr/bin/* ~/backup || echo $1

