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

my %file_count;
find( sub {
        if (-f $_) {
	    push(@{$file_count{$_}}, $File::Find::name);
	    #$file_count{$_}++;
	    #if ($file_count{$_} > 1) {
            #    print "$file_count{$_}: $File::Find::name\n";
            #}
	}
    }, $dropbox_dir);


my @files;
for my $key ( keys %file_count ) {
    if ( scalar(@{$file_count{$key}}) > 1 ) {
        for my $file_path ( @{$file_count{$key}} ) {
            push (@files, $file_path);
        }
    }
}


for (sort  @files) { print $_."\n"; }
