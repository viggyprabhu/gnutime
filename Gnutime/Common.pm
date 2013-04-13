package Gnutime::Common;

use strict;
use warnings;
sub storeUptime()
{
	my($packagename,$workdir, $uptime) = @_;
	my $storeDir = getStoreDir($workdir);
	if(!-d $storeDir)
    	{
		mkdir $storeDir;
    	}
	my $date = `date +%Y%m%d`;
	chomp($date);
	my $file = $storeDir."/".$date;
	if(-e $file)
	{
		open(FILE, $file) or die $!;
		while(<FILE>)
		{
			my $value = $_;
			$uptime=$uptime+$value;
		}	
		close(FILE);
	}
	open(my $fh, ">", $file) or die $!;
	print $fh $uptime;
	close($fh);
}

sub getStoreDir()
{
	my($workdir) = @_;
	return $workdir."/store";
}
sub updateUptime()
{
	my($workdir) = @_;
	##ToDo Find all the servers to update to
	print $workdir;
	if(isUpdateRequired($workdir))
	{
		
	}
	##Check which are all the uptime that you will have to update to servers
	##For each server to update, run its script along with the uptime so that you get all the params to pass it too.
	## Do a post request to the server with all the params.
	## Check if POST request was successful, if not retry 5 times.
	## Move all files with uptime to backup dir
}

sub isUpdateRequired()
{
	my($workdir) = @_;
	print "$workdir";
	#my $storeDir = getStoreDir($workdir);
	if(FileUtils->filesExists())
	{

	}

}
sub getAllServers()
{
	my($workdir) = @_;
	my $serverDir = getServerDir($workdir);
	##ToDo Get all the files in Server Dir
	##Store the first line of each file. It is supposed to a link to a web page which will accept POST requests with a particular format.
}

sub getServerDir()
{
	my($workdir) = @_;
	return $workdir."/servers";
	
}
sub createWorkdir()
{
    my ($workdir)=@_;

    if(!-d $workdir)
    {
	mkdir $workdir;
    }
}

sub captureUptime()
{
	my $currentUptime = `/usr/bin/uptime`;
	my $time = extractUptimeinSecs($currentUptime);
	return $time;
}

sub extractUptimeinSecs()
{
	my ($uptimeOutput) = @_;
	my $totalSecs = 0;
	my @spl = split(/,/,$uptimeOutput);
	my $imp;
	if($#spl+1==6)
	{
		$imp = $spl[0]." ".$spl[1];
	}
	else
	{
		$imp = $spl[0];
	}
	if($imp=~m/up (.+)$/)
	{
		my $uptime = $1;
	
		if($uptime=~m/^(.+) days$/)
		{
			$totalSecs = 86400*$1;
			return $totalSecs;
		}
		elsif($uptime=~m/^(.+) days (.*)$/)
		{
			$totalSecs = 86400*$1;
			$uptime=$2;
		}
		if($uptime=~m/^(.+) hrs$/)
		{
			$totalSecs=$totalSecs+($1*3600);
			return $totalSecs;
		}
		elsif($uptime=~m/^(.+) min$/)
		{
			$totalSecs = $totalSecs+($1*60);
			return $totalSecs;
		}
		elsif($uptime=~m/^(.+):(.+)$/)
		{
			$totalSecs = $totalSecs+($1*3600)+($2*60);
		}
		else
		{
			print "unknown format of $uptime";
			exit(-1);
		}
	}
}

sub getHardwareAddress()
{
   my $ifconfigResult = `ifconfig`;
   my @lines = split("\n",$ifconfigResult);
   foreach(@lines)
   {
      my $line = $_;
      if($line=~m/eth0/ && $line=~m/HWaddr (.+)$/)
      {
	 chomp $1; 
         return $1;
      }
   }
   return "";
}

sub generateUniqId()
{
    return 123;
}

1;
