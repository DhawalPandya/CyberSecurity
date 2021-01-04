#!/Bin/bash


grep -i " " 0* ./03* | awk -F" " '{print $1, $2, $3, $4,  $5, $6, $7, $8}'

