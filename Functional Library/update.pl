#!/usr/bin/perl

# Final Program Scripts
# Written by Chris Davis
# ID: 0879026

use CGI qw(:standard);
use DBI;
use CGI::Session;
use CGI::Cookie;
use File::Spec;

#%cookies = CGI::Cookie->fetch;

my $cookie = cookie('perl260');
unless ($cookie){
	$cookie = undef;
}
my $session = new CGI::Session (undef, $cookie, {Directory=>File::Spec->tmpdir()});

print header();

my $userName = "root";
my $password = "password";

my $dsn = "DBI:mysql:f13-final:localhost";
my $dbh = DBI->connect ($dsn, $userName, $password, {PrintError => 0 } );

if (!$dbh) {
	print header(), start_html(-title=>'Oops...'), "Not sure how I got here, but something is wrong", end_html();
} else {
	if ($session->param(loggedIn)){ # Check for session and/or cookie
		print start_html(-title=>'Update a Book in the Library System');
		#print $session->param(loggedIn);
		my $id = param ('txtID');
		my $sql = "SELECT * from tbllibrary WHERE libraryID = '$id'";
		my $sth = $dbh->prepare ($sql);
		my $returnCode = $sth->execute ();
		my $hashRef, $author, $title, $totalQty, $qtyAvail;

		if ($hashRef = $sth->fetchrow_hashref()){ # Book(s) was/were found
			$author = $hashRef->{'author'};
			$title = $hashRef->{'title'};
			$totalQty = $hashRef->{'totalCopies'};
			$qtyAvail = $hashRef->{'copiesAvailable'};
		} else {
			print "Sorry, but this book could not be found in the db.", br, end_html();
			print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.');
		}

		
		print "<center><h2>Welcome!</h2></center><br><center>Please enter the data for the book you would like to update in the Library's system.</center><br><br>";

		print "<form name=frmUpdate method=post action=\"/cgi-bin/updateBook.pl\"><table><tr><td>Title</td><td><input type=text name=txtTitle value=\"$title\"></td></tr>
<tr><td>Author</td><td><input type=text name=txtAuthor value=\"$author\"></td></tr>
<tr><td>Total Quantity</td><td><input type=text name=txtTotalQty value=\"$totalQty\"></td></tr>
<tr><td>Quantity Available</td><td><input type=text name=txtQtyAvail value=\"$qtyAvail\"></td></tr>
<input type =\"hidden\" name =\"txtID\" value =\"$id\">
<tr><td></td><td><input type=submit value=\"Update a Book\"></td></tr></table>";

		print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.');
	} else { # User not logged in
		print start_html(-title=>"oops");
		print "You don't have permission to run this page", br;
		print "Try logging in ", a({-href=>'/login.html'}, 'here'), br;
		print end_html();
	}
}
