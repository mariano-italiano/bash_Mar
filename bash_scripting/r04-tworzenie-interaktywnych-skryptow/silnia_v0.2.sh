#!/bin/bash
# Skrypt obliczający silnie

licz_silnie() {
  if [ $1 -eq 1 ] 
  then
    echo 1
  else
    local n=$(( $1 - 1 ))
    local wynik=$(licz_silnie $n)
    echo $(( $wynik * $1 ))
  fi
}

read -p "Podaj liczbe do obliczenia silni: " liczba
silnia=$(licz_silnie $liczba)
echo "Silnia liczby $liczba wynosi: $silnia"

