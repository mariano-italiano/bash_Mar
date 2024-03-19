#!/bin/bash
# Przechwycenie sygnału przerwania programu SIGINT oraz 
# sygnału zakończenia SIGTERM
 
CTRLC=0

function przechwyc_sygnal {
  CTRLC=$(( $CTRLC + 1 ))
  echo
  if [[ $CTRLC == 1 ]]; then
    echo "Zatrzymujemy"
  elif [[ $CTRLC == 2 ]]; then
    echo "Jeszcze chwila..."
  else
    echo "Poddaje się"
    exit
  fi
}

function przechwyc_zakonczenie {
  echo "Podjęto próbe ubicia programu przez kill'a - ale jesteśmy sprytniejsi :)"
}

trap przechwyc_sygnal SIGINT
trap przechwyc_zakonczenie SIGTERM

while true
do
  echo "Spimy..."
  sleep 10
done

