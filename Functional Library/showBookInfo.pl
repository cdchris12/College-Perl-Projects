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

if (!$dbh)
{
   print header(), start_html(-title=>'Oops...'), "Not sure how I got here, but something is wrong";
   print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.'), end_html();
}
else
{	
   print header(), start_html(-title=>'Book Search');
   #print "1", br;
   my $author = param ('txtAuthor');
   my $title = param ('txtTitle');
   #print $author, $title, br;
   my $sql;								#Good to here.
   if ($author && $title){
      $sql = "SELECT * from tbllibrary WHERE (author LIKE '\%$author\%') OR (title LIKE '\%$title\%')";
      #print "1", br;
   } elsif ($author && !$title) {
      $sql = "SELECT * from tbllibrary WHERE (author LIKE '\%$author\%')";
      #print "2", br;
   } elsif (!$author && $title) {
      $sql = "SELECT * from tbllibrary WHERE (title LIKE '\%$title\%')";
      #print "3", br;
   } else {
      $sql = "SELECT * from tbllibrary";
   }
   my $sth = $dbh->prepare ($sql);
   my $returnCode = $sth->execute ();

   my $hashRef, $flag;
   
   while ($hashRef = $sth->fetchrow_hashref()){ # Book(s) was/were found
      #print header(), start_html (-title=>'Book info for book ID #' . $hashRef->{'libraryID'});
      $flag = 1;
      print "<TABLE BORDER=2>", "\n";
      print Tr (td("Title "), td($hashRef->{'title'})), "\n";
      print "<TR>", td("Author "),  td($hashRef->{'author'}), "</TR>", "\n";
      print "<TR>", td("Total Copies on Hand "),       td($hashRef->{'totalCopies'}), "</TR>", "\n";
      print "<TR>", td("Copies Available "),      td($hashRef->{'copiesAvailable'}), "</TR>", "\n";
      if ($session->param(loggedIn)){ # Check for session and/or cookie
         unless ($hashRef->{'copiesAvailable'} >= $hashRef->{'totalCopies'}) {
			print "<form name=formSearch1 method=post action=\"/cgi-bin/checkIn.pl\"><tr><input type=submit value=\"Check Book In\"><input type = \"hidden\" name = \"txtID\" value = \"$hashRef->{'libraryID'}\"></tr></form>"; # Check In button
		}
         unless ($hashRef->{'copiesAvailable'} < 1) {
            print "<form name=formSearch2 method=post action=\"/cgi-bin/checkOut.pl\"><tr><input type=submit value=\"Check Book Out\"><input type = \"hidden\" name = \"txtID\" value = \"$hashRef->{'libraryID'}\"></tr></form>"; # Check Out button
         }

         print "<form name=formSearch3 method=post action=\"/cgi-bin/update.pl\"><tr><input type=submit value=\"Update Book Information\"><input type = \"hidden\" name = \"txtID\" value = \"$hashRef->{'libraryID'}\"></tr></form>"; # Update button
      }
      print "</TABLE>", "\n";
      print br, br;
   }
   unless ($flag)
   {
      print start_html(-title=>'Oops...'), "Unable to find that info in the db";
   }
   
   if (!$session->param(loggedIn) && $flag){ # Check for lack of a session and/or cookie
      print br, br, "If you need to check a book in, check a book out, or update a book's information, please login ", a({-href=>'/login.html'}, 'here'), br;
   } else {
      print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.');
   }
   print end_html();
}
