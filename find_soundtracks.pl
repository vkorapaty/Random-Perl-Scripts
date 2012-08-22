#!/usr/bin/perl
use strict;
use warnings;
use File::Copy;
use File::Spec;
use Data::Dumper;

my $gog_dir = File::Spec->rel2abs("GOG.com Downloads");
my $backup_dir = 'C:\\Users\\VK\\Downloads\\GOG_soundtracks_Zipped';

opendir my $dh, $gog_dir or die "Cannot open $gog_dir: $!";
# When this script was inside the gog_dir and gog_dir was = '.', I could use grep { -d } readdir $dh.
# I've moved the script out of that directory, and now I have to use grep { ! -d } instead. Don't know why.
my @dirs = grep { ! -d } readdir $dh;
closedir $dh;

# The game directories that were collected were just the directory names,
# joining the GOG directory to the game directories so they can then be opened.
@dirs = map { File::Spec->catdir($gog_dir, $_) } @dirs;

for my $game_dir (@dirs) {
    opendir my $game_extras, $game_dir or die "Cannot open $game_dir: $!";

    my ($search1, $search2) = ("soundtrack", "ost");
    my @st_files = grep { /$search1|$search2/i } readdir $game_extras;
    
    foreach my $st_file (@st_files) {
        my $st_path = File::Spec->catdir($game_dir, $st_file);
        print $st_path."\n";
        copy( $st_path, $backup_dir) or die "$st_path : $!";
    }

    closedir $game_extras;
}

#print "\n\n-------------------------------------------------------------------\n\n";
#
# This was the initial working version.
# Cleaned up version is above, grepping readdir in-place of the while loop.
#
#for my $game_dir (@dirs) {
#    opendir my $game_extras, $game_dir or die "Cannot open $game_dir: $!";
#
#    while (my $extras_file = readdir $game_extras) {
#        my ($search1, $search2) = ("soundtrack", "ost");
#        if ($extras_file =~ /$search1/i or $extras_file =~ /$search2/i) {
#            print "$extras_file\n";
#            my $st_path = File::Spec->catdir($game_dir, $extras_file);
#            copy( $st_path, $backup_dir) or die "$st_path : $!";
#        }
#    }
#
#    closedir $game_extras;
#}

# Written 8/20/2012
