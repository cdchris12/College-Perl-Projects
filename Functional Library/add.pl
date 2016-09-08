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
if ($session->param(loggedIn)){ # Check for session and/or cookie
	print start_html(-title=>'Add a Book to the Library System');
	#print $session->param(loggedIn);
	print "<center><h2>Welcome!</h2></center><br><center>Please enter the data for the book you would like to add to the Library's system.</center><br><br>";

	print "<form name=frmLogin method=post action=\"/cgi-bin/addBook.pl\"><table><tr><td>Title</td><td><input type=text name=txtTitle></td></tr><tr><td>Author</td><td><input type=text name=txtAuthor></td></tr><tr><td>Quantity on Hand</td><td><input type=text name=txtQty></td></tr><tr><td></td><td><input type=submit value=\"Add a Book\"></td></tr></table>";

	print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.');
} else { # User not logged in
	print start_html(-title=>"oops");
	print "You don't have permission to run this page", br;
	print "Try logging in ", a({-href=>'/login.html'}, 'here'), br;
	print end_html();
}
