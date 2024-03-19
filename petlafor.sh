#!/bin/bash

read -p "Podaj adres IP serwera: " ipAddr
octet1=`echo $ipAddr | cut -d "." -f 1`
octet2=`echo $ipAddr | cut -d "." -f 2`
octet3=`echo $ipAddr | cut -d "." -f 3`
octet4=`echo $ipAddr | cut -d "." -f 4`

octets=($octet1 $octet2 $octet3 $octet4)
num=0
for octet in "${octets[@]}" 
do
	num=$(( num + 1))
	echo $num 
	if [[ $octet = "192" && $num -eq 1 ]]; then
		NET_TYPE="Siec prywatna"
	fi
done

if [[ -n $NET_TYPE ]]; then
	echo $NET_TYPE
fi
