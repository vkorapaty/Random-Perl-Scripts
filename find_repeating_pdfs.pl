# Well, bother, here's a bunch of nice cheats: http://www.perlmonks.org/?node_id=136482

#!/usr/bin/perl
use strict;
use warnings;
use File::Spec;
use Data::Dumper;


sub file_or_dir {
    my ($base_dir, $questionable_path) = ( @_ );
    my $full_path = File::Spec->catfile($base_dir, $questionable_path);
    if (-f $full_path ) {
        print "File: $questionable_path";
	return "File";
    }
    else {
        $full_path = File::Spec->catdir($base_dir, $questionable_path);
        if (-d $full_path ) {
            print "Directory: $questionable_path";
	    return "Dir";
        }
    }
}

my $path = 'C:\Users\VK\Dropbox\Documents';
my ($volume,$directories,$file) = File::Spec->splitpath( $path );
my $dropbox_dir = File::Spec->catpath($volume,$directories,$file);

opendir my $dh, $dropbox_dir or die "Cannot open $dropbox_dir: $!";
my %tagged_items = map { $_ => file_or_dir($dropbox_dir, $_) } readdir $dh;
closedir $dh;

for my $keys (keys %tagged_items) {
    print "$keys: $tagged_items{$keys}\n";
}

