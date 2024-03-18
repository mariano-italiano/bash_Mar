#!/bin/bash

# Definicja funkcji
function sum {
	# Wczytywanie liczb od uzytkownika
	read -p "Podaj pierwsza liczba: " A
	read -p "Podaj druga liczbe: " B
	echo "$A + $B = " $(($A + $B))
}

# Wywołanie funkcji
sum

exit 0

