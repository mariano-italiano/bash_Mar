#!/bin/bash
# Skrypt ilustrujący działanie heredoc - wszystkie przypadki

# Przykład który interpretuje zmienne i zachowuje /t taby
cat > Plik1 << DELIMITER
        Test 123 $USER
        to jest testowy tekst
        uzywajacy heredocs
DELIMITER

# Przykład który nie interpretuje zmiennych ale zachowuje /t taby
cat > Plik2 << "DELIMITER"
        Test 123 $USER
        to jest testowy tekst
        uzywajacy heredocs
DELIMITER

# Przykład który  interpretuje zmienne ale nie zachowuje /t tabów
cat > Plik3 <<- DELIMITER
        Test 123 $USER
        to jest testowy tekst
        uzywajacy heredocs
DELIMITER
