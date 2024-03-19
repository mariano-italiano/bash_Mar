#!/bin/bash
# Skrypt tworzący drzewo katalogów
# ./drzewo.sh katalog1 2 3

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

