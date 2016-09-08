#!/usr/bin/perl 

# Final Program Scripts
# Written by Chris Davis
# ID: 0879026

use CGI qw(:standard);
use CGI::Session;
use CGI::Cookie;
use DBI;
use File::Spec;

my $cookie = cookie('perl260');
unless ($cookie){
	$cookie = undef;
}
my $session = new CGI::Session (undef, $cookie, {Directory=>File::Spec->tmpdir()});

my $userName = "root";
my $password = "password";

my $dsn = "DBI:mysql:f13-final:localhost";
my $dbh = DBI->connect ($dsn, $userName, $password, {PrintError => 0 } );

if (!$dbh) {
	print header(), start_html(-title=>'Oops...'), "Not sure how I got here, but something is wrong", end_html();
} else {
	my $id = param ('txtID');
	my $title = param('txtTitle');
	my $author = param('txtAuthor');
	my $totalQty = param('txtTotalQty');
	my $qtyAvail = param('txtQtyAvail');
	if ($session->param(loggedIn)){ # Check for session and/or cookie
		print header();
		my $sql = "UPDATE tbllibrary SET title = ?, author = ?, totalCopies = ?, copiesAvailable = ? WHERE libraryID = ?";
		my $sth = $dbh->prepare ($sql);
		my $returnCode = $sth->execute ($title, $author, $totalQty, $qtyAvail, $id);
		if ($returnCode){
			#Update successful
			print start_html(title=>"Updated Book in the db!");
			print "Book successfully updated in the db!", br;
			print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.'), end_html();
		} else {
			#Update Unsuccessful
			#print $returnCode, br, br;
			print "Sorry, but this record could not be updated in the db.", br, end_html();
			print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.');
		}
	} else {
		print header();
		print start_html(-title=>"oops");
		print "You don't have permission to run this page", br;
		print "Try logging in ", a({-href=>'/login.html'}, 'here'), br;
		print end_html();
	}
}
