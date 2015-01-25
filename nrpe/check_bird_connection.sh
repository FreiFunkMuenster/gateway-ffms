#!/bin/bash

# Check der bird-Verbindung 
# Die zu prüfende Verbindung wird als Paremeter übergeben

output=$( birdc show protocols | grep $1 )

if [[ "#$output" =~ ^.*[m][a][s][t][e][r].*[u][p].*[E][s][t][a][b][l][i][s][h][e][d].*$ ]]
then
    echo "OK - $output"
    exit 0
else
    echo "CRITICAL - $output"
    exit 2
fi


