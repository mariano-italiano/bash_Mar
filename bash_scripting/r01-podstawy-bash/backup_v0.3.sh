#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: OR/AND

echo "Tworzenie katalogu backup" && mkdir ~/backup || echo "Katalog już istnieje"
echo "Kopiowanie plików..." && cp /usr/bin/* ~/backup || echo "Coś poszło nie tak"
