#!/Bin/bash

# Roulette Schedule with day and time for March 10

# will run another script to compare with loss with player

echo "March 10, full Roulette schedule with day and time \n"

awk '{print $1, $2, $5, $6}' ./0310_Dealer_schedule > March10RouletteSchedule

echo "Script has been run successfully and saved in March10RouletteSchedule \n" 

#

