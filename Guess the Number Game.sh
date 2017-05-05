#!/bin/bash
# Written by James Brouillet
# Date Written: May 4th, 2017
# Last Modification: N/A
# Title: Guess the random number!
# Description: May 4th, 2017

# Terminal Clear Screen
clear

# Set Global Variables

SET="2" #for testing purposes
RANDOMNUMBER=$(( ( RANDOM % 10 )  + 1 )) #Pick Random Number between 1 and 10
TRIES=1 #Set Trial counter
PLAYAGAIN="Yes Quit" #Play again or leave the game
RETRY="A" #For loop purposes
VALID="^[0-9]+$" #Criteria for valid integers only
STUPIDERRORS="0" #Amount of stupid errors

#Game Functions
#Introduction
echo "Welcome to the Guess the number game!"
sleep 1
echo "I will pick a random whole number 1 and 10 and you will try and guess the number I've picked!"
sleep 2
echo "Picking the number now!"
sleep 2
printf "..."
sleep 2
printf "..."
sleep 2
printf "..."
sleep 2
echo -e "\nOkay got my number! Try and guess now! Remember only whole numbers between 1 and 10!"
read GUESS #Player types number here.

#Check if number is a valid integer.
until [ $RETRY = "B" ]; do #RETRY LOOP
	if ! [[ $GUESS =~ $VALID ]] || [[ $GUESS -lt "1" ]] || [[ $GUESS -gt "10" ]]; then  #Loop start for try again.
		if ! [[ $GUESS =~ $VALID ]]; then
			echo "This is not even a valid number! Please type a whole number!"
			read GUESS #try again 1
			STUPIDERRORS=$[STUPIDERRORS+1] #increase dumb errors by 1
		else
			if [[ $GUESS -lt "1" ]] && ! [[ $GUESS -gt "10" ]]; then #Pick is less than 1 but not more than 10
				echo "This number is smaller than 1! I said I wouldn't pick numbers smaller than 1! Try again!"
				STUPIDERRORS=$[STUPIDERRORS+1] #increase dumb errors by 1
				read GUESS
			else #Pick is more than 10 but not less than 1
				echo "This number is larger than 10! I said I wouldn't pick any numbers larger than 10! Try again!"
				STUPIDERRORS=$[STUPIDERRORS+1] #increase dumb errors by 1
				read GUESS
			fi
		fi
			
	else
			if [ $GUESS = $RANDOMNUMBER ]; then #correct guess
				echo "Wow, looks like you got it!"
				if [ $TRIES = "1" ]; then #guessed on the first try
					echo "You got this on your first try! Incredible!"
					exit 1
				else
					if [ $STUPIDERRORS = "0" ]; then #no dumb tries
						echo "It took you $TRIES to get the right number!"
						exit 1
					else #with dumb tries
						echo "It took you $TRIES to get the right number!"
						sleep 1
						echo "On top of that, you type in a value that was smaller than 1 or greater than 10 and tried to type in non whole numbers!"
						sleep 1
						echo "You tried to do this $STUPIDERRORS times!"
						TOTALTRIES=$( expr $TRIES + $STUPIDERRORS ) #add both for total tries
						sleep 1
						echo "That means in total, you tried $TOTALTRIES times before you got the right answer!"
					fi
					
					exit 1
				fi
			else #guess is valid and trial guess is incorrect
				echo "That wasn't the right number! Try again!"
				TRIES=$[TRIES+1]
				read GUESS
			fi
	fi
done
