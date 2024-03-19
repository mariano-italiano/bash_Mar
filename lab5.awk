#!/usr/bin/awk -f 

# Funkcja na znajdywanie ceny maksymalnej
function cenaMax(cena1, cena2){
        if (cena1 > cena2)
                return cena1
        else
                return cena2
}

# Funkcja na znajdywanie ceny minimalnej
function cenaMin(cena1, cena2){
        if (cena1 < cena2)
                return cena1
        else
                return cena2
}

# Funkcja na znajdywanie nazwy wina wg ceny
function znajdzWino(cenaMax){
       	where = match($4, cenaMax)
	if (where != 0){
            return $1
        }
}

# Program właściwy
BEGIN {
    FS=","
    max = 0
    min = 10000
}
{
# Wyświetlenie win z Francji
if (NR>1 && $2 == "Fra") { 
	print "Wino:",$1,"\nCena:", $4,"\n-----------------------" 
}

# Ddodanie do tablicy win innych niż z Francji
if (NR>1 && $2 != "Fra") {
	inne[$2]++
}

# Obliczenie ceny maksymalnej i minimalnej
if (NR>1) {
	max = cenaMax(max,$4)
	min = cenaMin(min,$4)
}

# Zapisanie nazwy wina najdroższego
if (length(znajdzWino(max)) > 0) {
    winoMax = znajdzWino(max)
}

# Zapisanie nazwy wina najtańszego
if (length(znajdzWino(min)) > 0) {
    winoMin = znajdzWino(min)
}


}

# Block END
END {

# Wypisanie wszystkich win NIE z Francji
for (wino in inne) 
	print "Liczba win z", wino,":", inne[wino]
 
# Wyświetlenie na czerwono i zielono nadroższego i najtańszego wina
print "-----------------------\n"
printf "Najtańsze wino: \033[1;32m" winoMin "\033[0m z ceną: \033[1;32m" min "\033[0m\n" 
printf "Najdroższe wino: \033[1;31m" winoMax "\033[0m z ceną: \033[1;31m" max "\033[0m\n\n"

}
