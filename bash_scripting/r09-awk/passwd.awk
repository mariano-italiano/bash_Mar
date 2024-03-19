#!/usr/bin/awk -f

function zielonyNaglowek(s) { 
    printf "\033[1;32m" s "\033[0m\n" 
}

BEGIN {
    FS=":"
    zielonyNaglowek("                Name   UID             Shell ") 
}
{
    printf "%20s %5d %17s\n",$1,$3,$7
}

