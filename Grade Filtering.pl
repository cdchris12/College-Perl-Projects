#!/usr/bin/perl -w
use strict;

# Created by Chris Davis
# ID Number: 0879026
# Midterm Program

print "\n\n PART ONE \n\n";

sub NumValid
{
	# Determines the number of valid numbers in the passed in array.
	
	my $aRef = shift;
	my $size = @{$aRef};
	
	my $i = 0;
	our $counter = 0;
	
	foreach (@{$aRef})
	{
		if ($_ > 200)
		{
			$_ = (0-1);
		}
		
		else
		{
			$counter++;
		}
	}
	
#	for ($i; $i < $size; $i++)
#	{
#		if (${$aRef}[i] > 200)
#		{
#			${$aRef}[i] = (0-1);
#		}
#		
#		else
#		{
#			$counter++;
#		}
#	}
	
	return $counter;
	
}

my @values1 = (191,192,193,194,195,196,197,201,202,203);
my @values2 = (1,2,3,4,5);
my @values3 = (341,342,343);
our $array_ref = \@values1;


print "Printing out the first array: \n";
print "@values1\n";
$array_ref = \@values1;
my $result = NumValid($array_ref);
print "Printing out the cleaned up first array: \n";
print "@values1\n";
print "The total number of valid values in the first array is: ";
print "$result";
print ".\n\n";

print "Printing the second array: \n";
print "@values2\n";
$array_ref = \@values2;
$result = NumValid($array_ref);
print "Printing out the cleaned up second array: \n";
print "@values2\n";
print "The total number of valid values in the second array is: ";
print "$result";
print ".\n\n";

print "Printing out the third array: \n";
print "@values3\n";
$array_ref = \@values3;
$result = NumValid($array_ref);
print "Printing out the cleaned up third array: \n";
print "@values3\n";
print "The total number of valid values in the third array is: ";
print "$result";
print ".\n\n";

print "\n\n PART TWO \n\n";

our %hash = ("John",20,"Mary",40);
$hash{"Qbert"} = 60;
$hash{"Rob"} = 80;
$hash{"The Dude"} = 230;

our $hash_ref = \%hash;

sub Credits
{
	our $hRef = shift;
	our $low = shift;
	our $high = shift;
	
	while (our ($k, $v) = each %$hRef)
	{
		if ($v >= $low)
		{
			if ($v <= $high)
			{
				print "$k:\t$v\n";
			}
		}
	}
	
	print "\n";
}


print "Printing out the entire pool: \n";
Credits($hash_ref,0,1000);

print "Printing out only freshmen: \n";
Credits($hash_ref,0,24);

print "Printing out only sophomores: \n";
Credits($hash_ref,25,59);

print "Printing out only juniors: \n";
Credits($hash_ref,60,89);

print "Printing out only seniors: \n";
Credits($hash_ref,90,200);