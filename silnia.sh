#!/bin/bash
# Skrypt obliczający silnie

licz_silnie() {
  if [ $1 -eq 1 ] 
  then
    echo 1
  else
    n=$(( $1 - 1 ))
    wynik=$(licz_silnie $n)
    echo $(( $wynik * $1 ))
  fi
}

silnia=$(licz_silnie $1)
echo "Silnia liczby $1 wynosi: $silnia"
