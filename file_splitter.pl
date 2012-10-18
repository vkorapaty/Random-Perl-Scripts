use strict;
use warnings;

use File::Spec;
use File::Find;
use Data::Dumper;
use IO::File;

my $win_path = 'C:\Users\VK\Desktop\helper_2';
my $file = 'ainbow_users.csv';
my $new_file = 'ainbow_split_';
my $file_ext = '.csv';
my $split_var = 30;

my $base_path = File::Spec->catpath(File::Spec->splitpath( $win_path ));
my $output_path = $base_path;
my $file_path = File::Spec->catfile($base_path, $file);

my ($file_line, $new_file_count) = (0,1);

my $handle = IO::File->new;
open($handle, "<", $file_path) or die "cannot open < $file: $!";

# Bug: Will not handle the end of the file properly. If file has 675 lines, 
# only 660 will be capture. The last 15 will be lost.
my @lines;
while (my $line = <$handle>) {
    $lines[$file_line] = $line;
    $file_line++;

    if ($file_line % $split_var == 0) {
        my $new_file_name = $new_file.$new_file_count.$file_ext;
       	my $out_file = File::Spec->catfile($output_path, $new_file_name);
	
       	my $fh = IO::File->new("> $out_file");
       	for (my $i = $file_line - $split_var; $i < $file_line; $i++) {
            print $fh $lines[$i];
        }
	$fh->close;

        $new_file_count++;
    }
}

close($handle);

print "$new_file_count created.\n";
