#!/Bin/bash

# Roulette Schedule with day and time for March 12

# will run another script to compare with loss with player

echo "March 12, full Roulette schedule with day and time \n"

awk '{print $1, $2, $5, $6}' ./0312_Dealer_schedule > March12RouletteSchedule

echo "Script has been run successfully and saved in March12RouletteSchedule \n" 

