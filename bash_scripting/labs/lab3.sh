#!/bin/bash
# Data: 01.01.2023
# Autor: Marcin Kujawski
# Opis: Skrypt tworzący wielu użytkowników z pliku
# Użycie: ./lab3.sh -f <input-file>
#

# Wczytanie parametrów 
while getopts "f:" flaga
  do
    case "${flaga}" in
      f) INPUTFILE=${OPTARG};;
    esac
  done

# Walidacja parametrów
if [ -z $INPUTFILE ] ; then
	echo 
	echo "Użycie skryptu:"
        echo " ./lab3.sh -f <input-file>"
        echo
        exit 0
fi

LINIA=0
IP=$(ip a | grep inet | grep ens | awk '{print $2}')
echo "Tworzę użytkowników:"
echo "-------------------------------------------------------------"

# Wczytanie pliku i procesowanie linia po lini
while read user ; do
	LINIA=$(( $LINIA + 1 ))
	
	# Wyłuskanie odpowiednich pól z pliku
	USERNAME=$(echo $user | awk -F',' '{print $1}')
	PASSWORD=$(echo $user | awk -F',' '{print $2}')
        USERSHELL=$(echo $user | awk -F',' '{print $3}')
        USERGEKOS=$(echo $user | awk -F',' '{print $4}')        

	# Walidacja czy zmianna USERNAME nie jest pusta
	if [ ! -z $USERNAME ] ; then

		# Tworzenie użytkownika
		useradd -s "$USERSHELL" -c "$USERGEKOS" "$USERNAME"
		if [ $? = 0 ] ; then
                        echo -e "Użytkownik\033[32m $USERNAME \033[0mzostał stworzony"
                fi

		# Ustawienie hasła i wymuszenie zmiany
		echo "$PASSWORD" | passwd "$USERNAME" --stdin > /dev/null 2>&1
		chage -d 0 $USERNAME
		if [ $? = 0 ] ; then
                        echo -e "Hasło dla użytkownika\033[32m $USERNAME \033[0mzostało ustawione poprawnie"
                fi
		
		# Tworzenie wiadomości powitalnej w pliku
		echo "Witam, konto na serwerze o adresie IP: $IP zostało utworzone. Dane do logowania:" > welcome_$USERNAME.txt
		echo >> welcome_$USERNAME.txt
		echo "Login: $USERNAME" >> welcome_$USERNAME.txt
		echo "Hasło: $PASSWORD" >> welcome_$USERNAME.txt
        	echo "Przy pierwszym logowaniu zmień hasło." >> welcome_$USERNAME.txt
		echo >> welcome_$USERNAME.txt
		echo "Pozdrawiam, Administrator" >> welcome_$USERNAME.txt
	        echo "Plik powitalny użytkownika: welcome_$USERNAME.txt"
		echo "-------------------------------------------------------------"
	else
		echo -e "\033[31mNiekompletne dane w pliku w lini $LINIA\033[0m"
		continue
        fi
done < $INPUTFILE

echo
exit 0
