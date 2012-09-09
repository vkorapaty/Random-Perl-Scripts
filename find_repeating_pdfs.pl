# Well, bother, here's a bunch of nice cheats: http://www.perlmonks.org/?node_id=136482

#!/usr/bin/perl
use strict;
use warnings;
use File::Spec;
use File::Find;
use Data::Dumper;


my $path = 'C:\Users\VK\Dropbox\Documents';
my ($volume,$directories,$file) = File::Spec->splitpath( $path );
my $dropbox_dir = File::Spec->catpath($volume,$directories,$file);

find(\&process_file, $dropbox_dir);
my $test_hash = weird_hash();

for my $key (keys %$test_hash) {
    print "$key: $test_hash->{$key}}\n";
}

sub process_file {
    if (-f $_) {
	print "$_\n";
	my $h = weird_hash();
	$h->{$_}++;
    }
}

# Not sure how to save the items found in process_file, attempting to do so
# using a closure. 
# Using this example:
# http://stackoverflow.com/questions/3045438/perl-closure-using-hash
sub weird_hash {
    my %h = {};
    return \%h;
}
