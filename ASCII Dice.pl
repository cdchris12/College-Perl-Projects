#!/usr/bin/perl -w
use strict;

#Created by Chris Davis
#ID Number: 0879026
#Program number 2
#This is a Craps program. It emulates playing a game of craps.

print "\n";
print "------ Let's play CRAPS! ------ \n";
print "\n";

my $balance = 500;
#Set beginning balance

sub play
#this sub plays the actual craps game, and returns the value of the won/lost amount
#as an integer.
{
	my $flag = 0;
	my $roll = 1;
	my $bet;
	my $dice1;
	my $dice2;
	my $diceTotal;
	my $point;
	my $trash;
	
	print "How much would you like to wager on this game of craps? \n";
	
	$bet = <STDIN>;
	chomp($bet);
	#Input the bet amount, then chomp the \n off to make it an integer.
	
	while ($bet > $balance)
	#Checks bet amount vs. balance
	{
		print "You don't have that much money! \n";
		print "How much would you like to wager on this game of craps? \n";
		
		$bet = <STDIN>;
		chomp($bet);
		#Input the bet amount, then chomp the \n off to make it an integer.
	}
	
	until ($flag == 1)
	#Create the loop so that you can roll until you wither win or lose.
	{
		print "Rolling the first dice: \n";
		$dice1 = rollD();
		#rollD() should return the result of the die roll
		
		print "Rolling the second dice: \n";
		$dice2 = rollD();
		#rollD() should return the result of the die roll
		
		$diceTotal = $dice1 + $dice2;
		print "The total die roll was ", $diceTotal, ". \n";
		
		if ($roll == 1)
		#Apply the special rules for the first roll
		{
			if ($diceTotal == 7 || $diceTotal == 11)
			#Win condition
			{
				$flag = 1;
				print "You won \$$bet, congratulations! \n\n";
				return $bet;
			}
			elsif ($diceTotal == 2 || $diceTotal == 3 || $diceTotal == 12)
			#Lose condition
			{
				$flag = 1;
				print "Oh no, you lost \$$bet. Better luck next time! \n\n";
				$bet *= -1;
				return $bet;
			}
			else 
			#Set the "point" for the next roll
			{
				$point = $diceTotal;
				print "On to the next roll. Press Enter to continue.";
				$roll += 1;
				$trash = <STDIN>;
				#Trash is only here so that we can provide some way for the player
				#to see each roll, instead of them scrolling rapidly.
				print"\n\n";
			}
		}
		
		elsif ($roll > 1)
		#Apply the normal roll rules
		{
			if ($diceTotal == $point)
			#Win condition
			{
				$flag = 1;
				print "You won \$$bet, congratulations! \n\n";
				return $bet;
			}
			elsif ($diceTotal == 7)
			#Lose condition
			{
				$flag = 1;
				print "Oh no, you lost \$$bet. Better luck next time! \n\n";
				$bet *= -1;
				return $bet;
			}
			else 
			#Set the "point" for the next roll
			{
				$point = $diceTotal;
				print "On to the next roll. Press Enter to continue.";
				$roll += 1;
				$trash = <STDIN>;
				#Trash is only here so that we can provide some way for the player
				#to see each roll, instead of them scrolling rapidly.
				print "\n\n";
			}
		}
	}
}

sub rollD
#this sub prints the rolled dice to the screen and returns its value as an integer.
{
	my $temp;
	#Makes a value to hold the random number
	
	$temp = int(rand(6)) + 1;
	#Generate a random number, between 1 and 6, called temp
	
	if ($temp == 1)
	#Print the die's 1st side
	{
		print " ________ \n";
		print "|        |\n";
		print "|        |\n";
		print "|    0   |\n";
		print "|        |\n";
		print "|________|\n";
		print "\n";
	}
	
	elsif ($temp == 2)
	#Print the die's 2nd side
	{
		print " ________ \n";
		print "| 0      |\n";
		print "|        |\n";
		print "|        |\n";
		print "|        |\n";
		print "|______0_|\n";
		print "\n";
	}
	
	elsif ($temp == 3)
	#Print the die's 3rd side
	{
		print " ________ \n";
		print "| 0      |\n";
		print "|        |\n";
		print "|    0   |\n";
		print "|        |\n";
		print "|______0_|\n";
		print "\n";
	}
	
	elsif ($temp == 4)
	#Print the die's 4th side
	{
		print " ________ \n";
		print "| 0    0 |\n";
		print "|        |\n";
		print "|        |\n";
		print "|        |\n";
		print "|_0____0_|\n";
		print "\n";
	}
	
	elsif ($temp == 5)
	#Print the die's 5th side
	{
		print " ________ \n";
		print "| 0    0 |\n";
		print "|        |\n";
		print "|    0   |\n";
		print "|        |\n";
		print "|_0____0_|\n";
		print "\n";
	}
	
	elsif ($temp == 6)
	#Print the die's 6th side
	{
		print " ________ \n";
		print "| 0    0 |\n";
		print "|        |\n";
		print "| 0    0 |\n";
		print "|        |\n";
		print "|_0____0_|\n";
		print "\n";
	}
	
	return $temp;
	#Return the value rolled.
}

print "Your current balance is \$$balance. \n";
print "Would you like to (p)lay or (q)uit? \n";

my $choice = <STDIN>;
chomp($choice);
#Read the player's choice and chomp off the \n to make it comparable to a character

until ($choice eq "q" || $choice eq "Q")
{
	$balance += play();
	print "Your current balance is now \$$balance. \n";
	#Play will return the win or loss, which gets added to the balance here.
	
	print "Would you like to (p)lay or (q)uit? \n";
	
	$choice = <STDIN>;
	chomp($choice);
	#Read the player's choice and chomp off the \n to make it comparable to a character
}

print "Your total winnings were \$";
print $balance - 500;
print ". \n";