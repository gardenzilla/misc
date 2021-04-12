#!/bin/bash

# All right reserved
# Gardenzilla
# Peter Mezei
# 2020
# Licensed under MIT

if [ $# -eq 0 ]
    then
        echo "Generate Gardenzilla Loyaltycard QR codes between a given INT range"
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
DIR="output/output_${FIRST}_${LAST}"

# Clean up output dir
rm -rf $DIR

# Create it
mkdir -p $DIR

for (( i = $FIRST; i <= $LAST; i++ )) 
do 
    echo -ne \\r"Processing QR codes $LAST/$i"
    code=$(gzid create $i)
    qrencode -o $DIR/${code^^}.svg 'lc/'$code -t SVG
done

echo ""
echo "DONE"
