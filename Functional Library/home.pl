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

print header(), start_html(-title=>'Home Page');
#print $session->param(loggedIn);
print "<center><h2>Welcome!</h2></center> <br>
		<center>What would you like to do at the library today?</center><br>
		<br>";

if ($session->param(loggedIn)){ # Check for session and/or cookie
	# Do nothing, user is logged in through db already
} else { # User not logged in.
	print "<center><form name=formLogin method=post action=\"/login.html\"><table><tr><td><input type=submit value=\"Log In\"></td></tr></table></form></center><br><br>"; # Login button
}

print "<center><form name=formSearch method=post action=\"/search.html\"><table><tr><td><input type=submit value=\"Search For A Book\"></td></tr></table></form></center><br><br>"; # Search button

		#<!-- Check for logged in before allowing the user to add a book. -->

if ($session->param('loggedIn')){ # Check for session and to see if user is logged in
	print "<center><form name=formAdd method=post action=\"/cgi-bin/add.pl\"><table><tr><td><input type=submit value=\"Add A Book\"></td></tr></table></form></center></body></html>";
}
