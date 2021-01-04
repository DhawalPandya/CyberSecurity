#!Bin/bash

#Script for March 10 with time, Loss and Dealer 

echo "Script has been run for 11:00:00 PM for March 12\n"

grep '0312' ./Player_Analysis/Roulette_Losses | grep '11:00:00 PM' | awk '{print $1, $2, $3}' >> ./Dealers_working_during_losses && grep '11:00:00 PM' ./Dealer_Analysis/March12RouletteSchedule | awk '{print $3, $4}' >> ./Dealers_working_during_losses

echo "\n " 

