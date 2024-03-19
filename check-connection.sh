#!/bin/bash
# Skrypt sprawdzający połaczenia do serwerów zdefiniowanych
# w pliku servers.txt i wyświetlający komunikat na czerwono 
# w przypadku braku połaczenia   

while read serwer ; do
        ping -c2 $serwer >/dev/null
	if [ $? = 0 ] ; then
		echo -e "\033[32mServer $serwer jest osiągalny\033[0m"
	elif [ $? = 1 ] ; then
		echo -e "\033[31mServer $serwer nie jest osiągalny\033[0m"
	else
		echo -e "\033[31mServer $serwer nie jest osiągalny, niestandardowy kod błedu\033[0m"
	fi
done < servers.txt
