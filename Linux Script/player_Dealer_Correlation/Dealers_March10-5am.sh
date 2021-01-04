#!Bin/bash

#Script for March 10 with time, Loss and Dealer 

grep '0310' ./Player_Analysis/Roulette_Losses | grep '05:00:00 AM' | awk '{print $1, $2, $3}' >> Dealers_working_during_losses && grep '05:00:00 AM' ./Dealer_Analysis/March10RouletteSchedule | awk '{print $3, $4}' >> Dealers_working_during_losses

echo "Script has been run for 05:00:00 AM for March 10\n"
