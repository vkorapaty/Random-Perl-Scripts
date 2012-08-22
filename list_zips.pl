#!/usr/bin/perl

use warnings;
use strict;
use IO::File;
use Digest::MD5;

sub md5sum {
    my $file = shift;
    my $digest = "";

    eval{
        open(FILE, $file) or die "Can't find file $file\n";
        my $ctx = Digest::MD5->new;
        $ctx->addfile(*FILE);
        $digest = $ctx->hexdigest;
        close(FILE);
    };

    if($@){
        print $@;
        return "";
    }

    return $digest;
}

# Opens the soundtrack file containing game names, associated zipped sound 
# track, and md5 hash for zip file.

my $file = "soundtrack_md5s";
my $handle = IO::File->new;
open($handle, "<", $file) or die "cannot open < $file: $!";

while (my $line = <$handle>) {
    # Game Name | Zipped Sound Track name | zip md5 checksum
    my @values = split(/ \| /, $line);
    chomp($values[2]);
    $values[2] =~ s/^\s+|\s+$//g;
    my $md5 =  md5sum($values[1]);
    if ($values[2] eq $md5) {
        print "$values[0] checks out.\n";
    }
    else {
	print "$values[0] md5 does not match.\n";
    }
}

close($handle);

# 8/19/12
