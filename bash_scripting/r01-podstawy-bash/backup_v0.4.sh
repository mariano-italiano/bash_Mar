#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Status wykonania

echo "Tworzenie katalogu backup" && mkdir ~/backup || echo "Katalog już istnieje"
echo "Kopiowanie plików..." && cp /usr/bin/* ~/backup || echo $?

