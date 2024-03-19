#!/bin/bash
# Data: 01.01.2023
# Autor: Marcin Kujawski
# Opis: Skrypt który zbiera informacje na temat wersji jądra systemu
# Użycie: ./lab1.sh -s <serwer IP>
#
# Lab 1
# Napisz skrypt Bash, który będzie sprawdzał wersję jądra zdalnego 
# systemu Linux, wyświetlając hostname i wersję jądra łącząc się 
# bezpiecznie po SSH (włączona autoryzacja po kluczach z pustą passfrazą). 
# Użyj kolorów i hostname wyświetl na zielono a wersję jadra na zółto. 
# Jako dane wejściowe użytkownik musi podać użytkownika do logowania 
# oraz ip serwera jako parametr z flagą -s.

# Pobranie IP serwera z parametrów skryptu
while getopts "s:" flag
  do
    case "${flag}" in
      s) serverIp=${OPTARG};;
    esac
  done

# Pobranie użytkownika do logowania
read -p "Podaj username dla $serverIp: " user

# Połączenie z serwerem oraz wydobycie jego wersji jadra i hostname
ssh ${user}@$serverIp 'echo -e "Wersja jądra systemu\033[32m $HOSTNAME \033[0mto:\033[33m `uname -r`\033[0m"'

echo
exit 0

