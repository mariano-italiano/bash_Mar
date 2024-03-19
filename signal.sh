#!/bin/bash

CTRLC=0

function get_sigint {
	CTRLC=$(( $CTRLC + 1 ))	
	echo
	if [[ $CTRLC == 1 ]] ; then
		echo "Wcisnałeś CTRL+C, ale ja działam dalej"
	elif [[ $CTRLC == 2 ]] ; then
		echo "Wcisnąłeś znowu po razu drugi CTRL+C, ale ja sie nie poddaje"
	else
		echo "Do trzech razy sztuka, kończe zabawe"
		exit 0
	fi
}

function get_sigterm {
	echo "Chcesz mnie ubić ale ja jestem sprytniejszy"
	DATE=$(date +"%d/%m/%Y %H:%M")
	echo "$DATE - Przechwycono sygnał SIGTERM" >> /tmp/signal.log	
}

trap get_sigterm SIGTERM

while true
do
	echo "Spie 10 sekund"
	sleep 10
done
