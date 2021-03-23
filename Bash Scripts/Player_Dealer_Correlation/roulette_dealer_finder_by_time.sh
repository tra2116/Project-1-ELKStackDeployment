#!/bin/bash
grep "$1" $2 | awk -F' ' '{print $3="", $4="", $7="", $8="", $0}'

