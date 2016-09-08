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
	print header(), start_html(-title=>'Oops...'), "Not sure how I got here, but something is wrong";
	print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.'), end_html();
} else {
	my $id = param ('txtID');
	if ($session->param(loggedIn)){ # Check for session and/or cookie
		print header();
		my $sql = "SELECT * from tbllibrary WHERE libraryID = '$id'";
		my $sth = $dbh->prepare ($sql);
		my $returnCode = $sth->execute ();
		my $hashRef, $num;

		if ($hashRef = $sth->fetchrow_hashref()){ # Book(s) was/were found
			print start_html(title=>'Book Checked Out');
			$num = $hashRef->{'copiesAvailable'};
			#print $hashRef->{'copiesAvailable'};
			if ($num > 0){ #Book has copies left in stock
				$num--;
				$sql = "UPDATE tbllibrary SET copiesAvailable = '$num' WHERE libraryID = '$id'";
				$sth = $dbh->prepare ($sql);
				$returnCode = $sth->execute ();
				
				print "Book successfully checked out!", br;
				print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.'), end_html();
			} else {
				print "Sorry, but there are no more copies of that book left for you to check out.", br;
				print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.'), end_html();
			}
		} else {
			print "Something went wrong and somehow the ID did not get passed to this script.", br;
			print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.'), end_html();
		}
	} else {
		print start_html(-title=>"oops");
		print "You don't have permission to run this page", br;
		print "Try logging in ", a({-href=>'/login.html'}, 'here'), br;
		print end_html();
	}
}
