#!/usr/bin/perl
use strict;
use warnings;
use File::Copy;
use File::Spec;
use Data::Dumper;

#my $dropbox_dir = File::Spec->rel2abs("C:\Users\VK\Dropbox\Documents");
#my $dropbox_dir = File::Spec->new("C:\Users\VK\Dropbox\Documents");
my $path = 'C:\Users\VK\Dropbox\Documents';
my ($volume,$directories,$file) = File::Spec->splitpath( $path );
my $dropbox_dir = File::Spec->catpath($volume,$directories,$file);

opendir my $dh, $dropbox_dir or die "Cannot open $dropbox_dir: $!";

#my @dirs = grep { -d } readdir $dh;
my %tagged_items = {};
for my $file_or_dir (readdir $dh) {
    my $full_path_of_file_or_dir = File::Spec->catfile($dropbox_dir, $file_or_dir);
    if (-f $full_path_of_file_or_dir ) {
        print "File: ";
    }
    else {
        $full_path_of_file_or_dir = File::Spec->catdir($dropbox_dir, $file_or_dir);
        if (-d $full_path_of_file_or_dir ) {
            print "Directory: ";
        }
  
    }
    print $file_or_dir."\n";
}

closedir $dh;

#print Dumper(@dirs);


## The game directories that were collected were just the directory names,
## joining the GOG directory to the game directories so they can then be opened.
#@dirs = map { File::Spec->catdir($dropbox_dir, $_) } @dirs;
#
#for my $dir (@dirs) {
#    opendir my $current_dir, $dir or die "Cannot open $dir: $!";
#        print $current_dir."\n";
#    closedir $current_dir;
#}
