#!/bin/bash

# All right reserved
# Gardenzilla
# Peter Mezei
# 2020
# Licensed under GNU GPLv3

if [ $# -eq 0 ]
    then
        echo "Generate Gardenzilla UPL QR codes between a given INT range"
        echo "Usage: generate.sh FROM TILL | example: generate.sh 1 1000 will generate QR codes from 1 till 1000"
        exit 1
fi

if [ -z "$1" ]
    then
        echo "No FROM argument given"
        exit 1
fi

if [ -z "$2" ]
    then
        echo "No TILL argument given"
        exit 1
fi

FIRST=$1
LAST=$2
DIR="output"

# Clean up output dir
rm -rf $DIR

# Create it
mkdir -p $DIR

for (( i = $FIRST; i <= $LAST; i++ )) 
do 
    echo -ne \\r"Processing QR codes $LAST/$i"
    qrencode -o $DIR/$i.svg 'http://gardenzilla.hu/upl/'$i -t SVG
done

echo ""
echo "DONE"
