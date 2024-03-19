#!/bin/bash
# Backup dla plików binarnych z /usr/bin
# Task: Przekierowania

echo "Tworzenie katalogu backup" && mkdir ~/backup 2>/dev/null || echo "Katalog już istnieje"
echo "Kopiowanie plików... " && cp /usr/bin/* ~/backup > log_file 2>&1
grep -i denied log_file | tail -n 1

