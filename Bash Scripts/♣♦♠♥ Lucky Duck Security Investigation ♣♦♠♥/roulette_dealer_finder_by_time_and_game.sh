#!/bin/bash

if [[ $3 == 'Roulette' ]]; then
grep "$1" $2 | awk -F' ' '{print $3="", $4="", $7="", $8="", $0}'
fi

if [[ $3 == 'BlackJack' ]]; then
grep "$1" $2 | awk -F' ' '{print $5="", $6="", $7="", $8="", $0}'
fi

if [[ $3 == 'Texas_Hold_EM' ]]; then
grep "$1" $2 | awk -F' ' '{print $3="", $4="", $5="", $6="", $0}'
fi
