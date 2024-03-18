#!/bin/bash
# Skrypt tworzący drzewo katalogów
# ./drzewo.sh 

# Funkcja
stworz_katalogi() {
        local depth=$2
        local i
        if [[ $depth -gt 0 ]]
        then
                for ((i=1;i<=$3;i++))
                do
                        mkdir -p $1/$i
                        stworz_katalogi "$1/$i" $((depth-1)) $3
                done
        fi
}

# Wczytanie danych
read -p "Podaj nazwe katalogu roota drzewa: " katalog
read -p "Podaj ilość katalogów która ma się utworzyć: " ilosc
read -p "Podaj głębokość drzewa katalogów: " glebokosc

echo -n "Czy na pewno chcesz stworzyć te katalogi ?"
read -n1 -p "Press any key to continue..."
stworz_katalogi $katalog $glebokosc $ilosc
