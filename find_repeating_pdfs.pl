# This helped more than anything:
# http://www.stonehenge.com/merlyn/LinuxMag/col45.html

#!/usr/bin/perl
use strict;
use warnings;
use File::Spec;
use File::Find;
use Data::Dumper;


my $path = 'C:\Users\VK\Dropbox\Documents';
my ($volume,$directories,$file) = File::Spec->splitpath( $path );
my $dropbox_dir = File::Spec->catpath($volume,$directories,$file);

# Using File::Find to find all of the files, and then store them into the 
# %file_count hash. The hash is a hash of arrays, where the key is the file
# found and the values linked to each key are the various paths where the
# file is found.
my %file_count;
find( sub {
        if (-f $_) {
            push(@{$file_count{$_}}, $File::Find::name);
        }
    }, $dropbox_dir);

# Going through the HoA to retrieve the directories for repeating files.
my @files;
for my $key ( keys %file_count ) {
    if ( scalar(@{$file_count{$key}}) > 1 ) {
        for my $file_path ( @{$file_count{$key}} ) {
            push (@files, $file_path);
        }
    }
}

# All of the results have $base_path prepended to them. Interestingly, '' don't
# work with \Q\E. Should look more into how quotemeta works.
# The mapped regex will remove that, the results will be sorted, and then printed.
# I think I may be going overboard with using map here.
my $base_path = "C:\\Users\\VK\\Dropbox\\Documents\/";
# Localizing $_ in map for regex is important. Otherwise, get only 1 or 0
# success/fail output.
map { print "$_\n"; } # Grouped by directory
    sort map { (my $s = $_ ) =~ s/\Q$base_path\E//; $s } @files;
#map { print "$_\n"; } # Grouped by file
#    map { (my $s = $_ ) =~ s/\Q$base_path\E//; $s } @files;
