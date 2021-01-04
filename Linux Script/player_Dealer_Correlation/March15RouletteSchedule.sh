!/Bin/bash

# Roulette Schedule with day and time for March 15

# will run another script to compare with loss with player

echo "March 15, full Roulette schedule with day and time \n"

awk '{print $1, $2, $5, $6}' ./0315_Dealer_schedule > March15RouletteSchedule

echo "Script has been run successfully and saved in March10RouletteSchedule \n" 

