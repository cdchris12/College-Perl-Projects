#!/usr/bin/perl -w
use strict;

# Created by Chris Davis
# ID Number: 0879026
# Program number 3
# This is a program which uses the SongUtility Module

use SongUtility;

my $stuff = SongUtility->loadList("datafile.txt");
# this should load from a file
# $stuff tells us whether it loaded or not

SongUtility->printSongs();
print "\n";
# This should print the list of songs

$stuff = SongUtility->isSongInList("blah blah blah");
# Searches the list
# $stuff tells us if that song is in the list

$stuff = SongUtility->removeSong("blah blah blah");
# This should remove a song from the loaded list of songs

$stuff = SongUtility->numberOfSongs;
# This should return the total number of songs in our list

SongUtility->printSongs();
print "\n";
# This should print the list of songs

SongUtility->addSong("Perl rox", "23:12");
# Adds a song to the list

SongUtility->printSongs();
print "\n";
# This should print the list of songs

$stuff = SongUtility->saveList("datafile.txt");
# Saves the list as it is after modification

print $stuff;