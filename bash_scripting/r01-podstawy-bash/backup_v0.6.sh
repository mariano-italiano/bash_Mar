#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Wiele argumentów skryptu

echo "Wykonywanie skryptu: $0"
echo "Tworzenie katalogu backup" && mkdir ~/backup || echo "Katalog już istnieje"
echo "Kopiowanie plików... " && cp /usr/bin/* ~/backup || echo $*

