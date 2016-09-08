package SongUtility;
use strict;
use Data::Dumper;

# Created by Chris Davis
# ID Number: 0879026
# SongUtility Module
# This is a module which serves to provide a methodology for keeping track of a music collection.

use Exporter qw(import);
 
our @EXPORT = qw(addSong removeSong numberOfSongs clear printSongs saveList loadList);

our %songs;

sub addSong
{
	if ("$_[0]" eq "SongUtility")
	{
		$songs{$_[1]} = $_[2];
	}
	else
	{
		$songs{$_[0]} = $_[1];
	}
	
	# $_[0] is the title
	# $_[1] is the time
	# Time is a string, formatted as "XX:XX"
	#
	# Adds a song to the list. If that song already exists, we update the information.
}

sub removeSong
{
	my $flag;
	if ("$_[0]" eq "SongUtility")
	{
		$flag = isSongInList("$_[1]");
	}
	else
	{
		$flag = isSongInList("$_[0]");
	}
	#print $flag;
	#print "\n";
	#print $_[0];
	#print "\n";
	#print $_[1];
	if ($flag)
	{
		if ($_[0] eq "SongUtility")
		{
			delete $songs{$_[1]};
		}
		else
		{
			delete $songs{$_[0]};
		}
		return 1;
	}
	else
	{
		return 0;
	}
	
	# $_[1] is the title
	#
	# Removes a song from the list and returns T/F based on whether the song was found in the list.
}

sub isSongInList
{
	my $value = $_[0];
	#print $_[0];
	my ($k, $v);
	while ( ($k , $v) = each %songs )
	{
		if ($k eq $value)
		{
			return 1;
		}
	}
	return 0;
	
	# $_[0] is the title
	#
	# Returns T/F based on whether or not the song is in the list.
	# NOT CASE SENSITIVE
}

sub numberOfSongs
{
	my $i = 0;
	$i = keys %songs;
	return $i;
	
	# No Args
	#
	# Returns the number of songs in the list
}

sub clear
{
	%songs = ();
	
	# No Args
	#
	# Clears all songs from the array
}

sub printSongs
{
	my @keys = sort { lc($a) cmp lc($b) } keys %songs;
	
	foreach my $key ( @keys ) {
	    printf "%-20s %20s\n", $key, $songs{$key};
	}
	
	#print Dumper (\%songs, "\n");
	
	# No Args
	#
	# Returns a single scalar containing a list of the songs in the list and their play time, one per line.
	# Must sort the list alphabetically before printing
	# Times need to be right justified
}

sub saveList
{
	my $test = (open (MYFILE1, ">>$_[1]"));
	
	#print "$_[1]";
	my ($k, $v);
	if ($test)
	{
		while ( ( $k, $v ) = each %songs ) 
		{
			print MYFILE1 $k;
			print MYFILE1 ",";
			print MYFILE1 $v;
			print MYFILE1 "\n";
		}
		close (MYFILE1);
		return 1;
	}
	else
	{
		return 0;
	}
	
	# $_[1] is the name of the datafile
	#
	# Saves a list of songs to the datafile, one song per line. The name and runtime should be comma seperated
	# Returns T/F based on whether or not the file was successfully saved.
}

sub loadList
{
	my $test = (open (MYFILE, "$_[1]"));
	#print "$_[1]";
	if ($test)
	{
		my ($k, $v);
		clear();
		while (my $line = <MYFILE>)
		{
			chomp ($line);
			($k, $v) = split (",", $line);
			addSong($k,$v);
		}
		close (MYFILE);
		return 1;
	}
	else
	{
		return 0;
	}

	# $_[1] is the name of the datafile
	#
	# Fills the list with songs which come from the datafile. 
	# Should have a call to clear() before starting, IF DATA FILE IS FOUND
	# Returns T if datafile is found and data is loaded into the array, and does nothing, other than returning F, if the datafile cannot be found.
}

1;
