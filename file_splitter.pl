use strict;
use warnings;

use File::Spec;
use Data::Dumper;
use IO::File;

# The purpose of this script is to split a single file into multiple parts. The file is split on line breaks.

# win_path is the directory where the file to be split is kept, and will also be the output directory for the split files.
# file is the file to be split
# new_file is the starting part of the file name, appended to this will be the partition id
# file_ex is the file extension for all of the split files
# split_var is how many lines per split file

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

# Reading in the file, for every $split_var lines, those lines will be written
# to a file.
my @lines;
my $last_written;
while (my $line = <$handle>) {
    $lines[$file_line] = $line;
    $file_line++;

    if ($file_line % $split_var == 0) {
	write_files( $file_line, \@lines, $new_file_count );

        $new_file_count++;
	$last_written = $file_line;
    }
}

close($handle);

# This handles the end lines that were not handled in the while loop.
write_files( $last_written, \@lines, $new_file_count, scalar @lines, 1 );


# write_files( $file_line, \@lines, $file_count )
# write_files( $file_line, \@lines, $file_count, $line_count, 1 )
sub write_files {
    my ($end, $lines, $file_count, $end_end, $final_flag) = @_;

    my $new_file_name = $new_file.$file_count.$file_ext;
    my $out_file = File::Spec->catfile($output_path, $new_file_name);
    print "File to be created: $out_file\n";

    my $fh = IO::File->new("> $out_file");
    if ( $final_flag) {
        for (my $i = $end; $i < $end_end; $i++) {
            print $fh $$lines[$i];
        }
    }
    else {
        for (my $i = $end - $split_var; $i < $end; $i++) {
            print $fh $$lines[$i];
        }
    }
    $fh->close;
}
