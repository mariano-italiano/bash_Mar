#!/bin/bash

tab1=(1 5 10 15 20)
for (( i=0; i<${#tab1[@]}; i++ )) 
do 
	echo ${tab1[$i]} 
done
