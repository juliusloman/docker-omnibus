#!/usr/bin/perl
# This is a simple CGI script for Webtop that will launch a web application
# using values passed from Webtop, such as event fields and values
# (i.e., Node, Summary, etc.)
#
# CHANGE HISTORY
# Created 2002May02 by David Millis
# 2002Aug23	Tweaked to launch topoviz ..dmillis
#

#
# HTML VARIABLES
#
# Affects the look & feel of the initial banner / form that is displayed
# Make sure that values are valid HTML (i.e, "blue", "#ccccff", etc.)
#
$Background_color = "white";
$Text_color = "black";

#
# Application defaults
#
$Default_USERNAME = "root";
$Default_PASSWORD = "";
$Default_Serial = '';


#############################
# Should not need to set anything below here ...
#############################

#
# Main
#
select((select(STDOUT), $| = 1)[0]);      # Force non-buffered I/O

($Prog = $0) =~ s%.*/%%;
my $error = "";
my $junk;

#
# Get the input variables that MAY have been posted to us
#
$buffer = $ENV{'QUERY_STRING'};
@pairs = split(/&/, $buffer);

#
# Step through all the name/value pairs
#
foreach $pair (@pairs) {
  ($name, $value) = split(/=/, $pair);
  # Un-Webify plus signs and %-encoding
  $value =~ tr/+/ /;
  $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  $name =~ tr/+/ /;
  $name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  # strip out prepended '$selected_rows.' that webtop adds
  $name =~ s/\$selected_rows\.//g;
  $FORM{$name} = $value;
  # Discard extra values (if user selected multiple rows)
  ($FORM{$name}, $junk) = split (',', $FORM{$name}, 2);
}

#
# Build a URL using passed values if possible
#
if (defined $FORM{'ServerSerial'}) {
  $URL = "../eventviewer/eventViewer.jsp?transientname=ShowSuppressedEvents&viewname=NetworkManagementEvents&viewtype=global&sql=NmosSerial%3D'$FORM{'ServerSerial'}'%20AND%20ServerName%3D'$FORM{'ServerName'}'";
} else {
  $URL = "../eventviewer/eventViewer.jsp?transientname=ShowSuppressedEvents&viewname=NetworkManagementEvents&viewtype=global&sql=NmosSerial%3D2";
}

#
# Allow the calling page to specify a URL
#
if (defined $FORM{'URL'}) {
  $URL = $FORM{'URL'};
} else {
  $URL = "" unless ($URL);
}

#
# Display an HTML page to the browser, redirecting them to new URL
#
print STDOUT "Content-type: text/html\n\n";
print STDOUT "<html>\n";
print STDOUT "<head>\n";
if (defined $FORM{'NmosCauseType'} and $FORM{'NmosCauseType'} == 1) {
  print STDOUT "<meta http-equiv=\"Refresh\" \n";
  print STDOUT "content=\"0;url=$URL\">\n";
  print STDOUT "<title>Preparing Event List...</title>\n";
  print STDOUT "</head>\n";
  print STDOUT "<body style=\"background-color: $Background_color; ";
  print STDOUT "color: $Text_color\">\n";
  print STDOUT "<h2>Preparing Event List...</h2>\n";
} else {
  print STDOUT "</head>\n";
  print STDOUT "<body style=\"background-color: $Background_color; ";
  print STDOUT "color: $Text_color\">\n";
  print STDOUT "<h2>Error</h2>\n";
  print STDOUT "This is not a root cause event (NmosCauseType = 1)\n";
  print STDOUT "<pre>\n";
  for $field (sort keys %FORM) {
    print STDOUT "Field $field is $FORM{$field};\n";
  }
}
print STDOUT "</body></html>\n";
