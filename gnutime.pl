#!/usr/bin/perl -w
use strict;
require Gnutime::Common;


my $hwAddr = Gnutime::Common->getHardwareAddress();
my $id = Gnutime::Common->generateUniqId($hwAddr);
my $gnutimeDir = (getpwuid $>)[7]."/.gnutime";
Gnutime::Common->createWorkdir($gnutimeDir);
my $uptime = Gnutime::Common->captureUptime();
#print "gnutimedir: ".$gnutimeDir;
#print "uptime: ".$uptime;
Gnutime::Common->storeUptime($gnutimeDir,$uptime);
Gnutime::Common->updateUptime($gnutimeDir);



