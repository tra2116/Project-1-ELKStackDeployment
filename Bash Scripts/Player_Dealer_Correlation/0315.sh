#!/bin/bash
grep -i '05:00:00\ AM\|08:00:00\ AM\|02:00:00\ PM' 0315_Dealer_schedule | awk -F' ' '{print $3="", $4="", $7="", $8="", $0}'


