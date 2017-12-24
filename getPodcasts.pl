#!/usr/bin/perl

# Script to download latest editions of various podcasts

use strict;
use LWP::Simple;

# Radio y Televisión Española
sub getRTVE
{
	my ($url,$file) = @_;
	my $content = get($url) or die $!;
	if($content =~ /(http:\/\/mvod.*\.mp3)/)
	{
		my $mp3url = $1;
		print("$file\n");
		getstore($mp3url,$file);
	}
}

# Deutsche Welle
sub getRSS
{
	my ($url,$file) = @_;
	my $content = get($url) or die $!;
	if($content =~ /(http:\/\/.*\.mp\d)/)
	{
		my $mp3url = $1;
		print("$file\n");
		getstore($mp3url,$file);
	}

}

# delete old mp3 files
system("rm -- *.mp3");

# CBS
getRSS("http://cbsradionewsfeed.com/rss.php?id=126&ud=12","CBS-News.mp3");

# Deutsche Welle (DW)
getRSS("http://rss.dw.com/xml/podcast_global-3000","DW-Global3000.mp3");
getRSS("http://rss.dw.com/xml/podcast_journal-reporter","DW-Reporter.mp3");
getRSS("http://rss.dw.com/xml/podcast_wissenschaft","DW-Wissenschaft.mp3");
getRSS("http://rss.dw.com/xml/podcast_shift","DW-Shift.mp3");
getRSS("http://rss.dw.com/xml/podcast_made-in-germany","DW-MadeInGermany.mp3");
getRSS("http://rss.dw.com/xml/podcast_projekt-zukunft","DW-Zukunft.mp3");
getRSS("http://rss.dw.com/xml/DKpodcast_topthemamitvokabeln_de","DW-Vokabeln.mp3");
getRSS("http://rss.dw.com/xml/DKpodcast_alltagsdeutsch_de","DW-Alltags.mp3");
getRSS("http://rss.dw.com/xml/podcast_jornal-pt","DW-Portugues.mp3");

# Radio y Televisión Española (RTVE)
getRTVE("http://www.rtve.es/alacarta/audios/a-hombros-de-gigantes/","RTVE-Hombros.mp3");
getRTVE("http://www.rtve.es/alacarta/audios/cruz-roja/","RTVE-CruzRoja.mp3");
getRTVE("http://www.rtve.es/alacarta/audios/cinco-continentes/","RTVE-Continentes.mp3");
getRTVE("http://www.rtve.es/alacarta/audios/america-hoy/","RTVE-AmericaHoy.mp3");
getRTVE("http://www.rtve.es/alacarta/audios/emision-en-ruso/","RTVE-Ruso.mp3");
getRTVE("http://www.rtve.es/alacarta/audios/emision-en-portugues/","RTVE-Portugues.mp3");


# Find mounted USB stick
my $entry = `mount | grep /media/traes`;
my @elements = split(" ",$entry);
my $usbdir = @elements[2];

# Copy MP3 files to USB stick
if(length($usbdir) > 0)
{
	print "copying to $usbdir...\n";
	`cp *.mp3 $usbdir`;
	print(`ls -lh $usbdir`);
}
else
{
	print("ERROR: could not find USB stick\n");
}

# done
print("done\n");
