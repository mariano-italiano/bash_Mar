#!/bin/bash
# Skrypt sprawdzający połaczenia do serwerów zdefiniowanych
# w pliku servers.txt i wyświetlający komunikat na czerwono 
# w przypadku braku połaczenia   

while read serwer ; do
        ping -c2 $serwer
	if [ $? = 1 ] ; then
		echo -e "\033[31mServer \033[33m$serwer\033[31m nie jest osiągalny\033[0m"
	fi
done < servers.txt
