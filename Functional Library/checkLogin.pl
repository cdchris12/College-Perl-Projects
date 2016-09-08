#!/usr/bin/perl

# Final Program Scripts
# Written by Chris Davis
# ID: 0879026

use CGI qw(:standard);
use CGI::Session;
use CGI::Cookie;
use DBI;
use File::Spec;



# this is where you verify the info against the database

#print header();

my $userName = "root";
my $password = "password";

my $dsn = "DBI:mysql:f13-final:localhost";
my $dbh = DBI->connect ($dsn, $userName, $password, {PrintError => 0 } );

if (!$dbh)
{
   print header();
   print start_html(-title=>'Oops...'), "Not sure how I got here, but something is wrong";
   print br, br, a({-href=>'/cgi-bin/home.pl'}, 'Click here to return to the home screen.'), end_html();
} else {								
   my $passedUsername = param ('txtUsername');
   my $passedPassword = param ('txtPassword');
   my $sql = "SELECT * from tblusers WHERE (login LIKE '$passedUsername') AND (password LIKE '$passedPassword')";
   my $sth = $dbh->prepare ($sql);
   my $returnCode = $sth->execute ();

   my $hashRef;

   if ($hashRef = $sth->fetchrow_hashref())
   {
      # Successfully verified login info in the db

      #Create cookie on the server with user information - name, logged in status, ...
      #1st argument - dsn info - leave blank
      #2nd argument - session id, set to undef to create a new session
      #3rd - where should the cookie be stored on the server

      my $session = new CGI::Session (undef, undef, {Directory=>File::Spec->tmpdir()});
      $session->param('loggedIn', 'yes');
      $session->param('username', $passedUsername);
      $session->close();

      #create a cookie on the client that links to the server cookie
      my $cookie = cookie (-name => 'perl260',
                           -value => $session->id,
                           -expires => '+30s'
                          );
      #$cookie->bake;
      print header(-cookie=>$cookie), start_html(-title=>"Logged in");
      print br, br;
      #print $session->id, br;
      #print $cookie;
      print a({-href=>'/cgi-bin/home.pl'}, 'Click here to go to the check in screen.');
      print end_html();
   }
   else
   {
      print header();
      print start_html("oops");
      print "Your login is invalid.", br;
      print "Try logging in ", a({-href=>'/login.html'}, 'here'), br;
      print end_html();

      # Login Info not found in db
   }
}


