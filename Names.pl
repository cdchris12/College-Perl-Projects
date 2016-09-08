#!/usr/bin/perl -w
use strict;

print "\n";
print "------ PART ONE ------ \n";
print "\n";

my $name;
my $ucname;
my @aname;

print "Enter your name: \n";
$name = <STDIN>;
print "\n";

@aname = split(' ', $name);
$ucname = uc($name);
chomp($ucname);

print ("Your first name is: %10s. \n", $aname[0]);
print ("Your last name is: %10s. \n", $aname[1]);
print ("Your full name is: %10s, %s. \n", $aname[1], $aname[0]);
print ("Your capitalized name is: %10s. \n", $ucname);

print "\n";
print "------ PART TWO ------ \n";
print "\n";

print "Enter your number: \n";
my $number = <STDIN>;
print "\n";

my $hundreds;
my $tens;
my $ones;

$ones = $number % 10;

$tens = $number % 100;
$tens = $tens - $ones;
$tens = $tens / 10;

$hundreds = $number - ($tens * 10);
$hundreds = $hundreds - $ones;
$hundreds = $hundreds / 100;

printf ("Hundreds: %28d \n", $hundreds);
printf ("Tens: %32d \n", $tens);
printf ("Ones: %32d \n", $ones);
printf ("The original number was: %13d \n", $number);