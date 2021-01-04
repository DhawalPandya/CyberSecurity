#!/Bin/bash


grep -i " " 0* ./03* | awk -F" " '{print $1, $2, $5, $6}'


#cat $1_Dealer_schedule | awf -F" " '{print $1, $2, $5,$6}'| grep "$2"
