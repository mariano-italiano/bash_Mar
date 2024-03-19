#!/bin/bash
# Pętla While

LICZBA=10
while [ $LICZBA -ge 0 ] ; do
  echo "Odliczam: $LICZBA"
  sleep 1
  LICZBA=$(( $LICZBA - 1 ))
done
