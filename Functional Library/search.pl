#!/usr/bin/perl

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

#unless ($session->param(loggedIn)){ # Check for session and/or cookie)
#	print header();
#    print start_html("oops");
#    print "You don't have permission to run this page", br;
#    print "Try logging in ", a({-href=>'/login.html'}, 'here'), br;
#    print end_html();
#} else { #Verified logged in past this point

	print header(), start_html();
	#print $session->param(loggedIn);
	print "<center>What book would you like to search for?</center><br><br>";
	

	print "<form name=frmLogin method=post action=\"/cgi-bin/showBookInfo.pl\">
<table>
   <tr> <td>Author</td> <td><input type=text name=txtAuthor> </td> </tr>
   <tr> <td>Title</td> <td><input type=password name=txtTitle> </td> </tr>
   <tr> <td></td> <td><input type=submit value=\"Run Search\"> </td> </tr>
</table>
</form>";
	#print start_form (-method=>'POST', -action => 'showBookInfo.pl');
	#print "Author: ", textfield(-name=>'txtAuthor', -size=>'30'), br;
	#print "Title: ", textfield(-name=>'txtTitle', -size=>'30'), br;
	#print submit(-name => 'cmdRunSearch', -value => 'Run Search');
#}
