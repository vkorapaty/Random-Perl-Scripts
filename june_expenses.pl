#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;
use Text::CSV;
use Data::Dumper;

my @rows;
my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
             or die "Cannot use CSV: ".Text::CSV->error_diag ();

open my $fh, "<:encoding(utf8)", "transactions.csv" or die "transactions.csv: $!";
while ( my $row = $csv->getline( $fh ) ) {
    if ( $row->[0] =~ m/6\/\d+\/2012/ 
        && $row->[4] =~ /debit/ ) {
        #print Dumper($row); #$row."\n";
        push @rows, $row;
    }
}

my $sum = 0;
my $food = 0;
@rows = sort { $a->[5] cmp $b->[5] } @rows;
foreach my $row ( @rows ) {
    printf "%-11s %-20s %-11s %-11s \n", $row->[0] , $row->[1] , $row->[3] , $row->[5];
   $sum += $row->[3];
   if ( $row->[5] =~ /Fast Food/ ) {
       $food += $row->[3];
   }
}

print "\nTotal spent in June: $sum\n";
print "Food in June: $food\n";
