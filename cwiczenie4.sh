#!/bin/bash

echo "-------sposob 1-------"

for i in {1..15..2} ; do 
	echo $i
done

echo "-------sposob 2-------"

for i in $(seq 1 2 15) ; do
        echo $i
done

echo "-------sposob 3-------"

for (( i=1; i<=15; i+= 2))
do
	echo $i
done

echo "-------sposob 4-------"

for i in {1..100} ; do
	if (( i % 2 == 0 )); then
		continue
	fi
	echo $i
	if (( i == 15 )); then
	break	
	fi
done
