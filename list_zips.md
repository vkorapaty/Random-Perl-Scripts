source for md5sum script used:
http://coding.debuntu.org/perl-calculate-md5-sum-file

Downloaded the sountracks from the Humble Bundles that I own (2 and 4), and wanted a script that would check all of the files against their checksum. To get a list of the checksums, I basically copied and pasted the music download page of both bundles into a text file. Then used vim to format the soundtrack_md5s text file with the name of the game, the name of the soundtrack zip file, and the hash. There's probably was a better way to go about it, but this was straight-forward enough for me. 

For the script, I first looked up how to create a md5 hash for a file with perl, found out about Digest::MD5. Ended up finding a script that basically did what I was looking for, that's where the md5sum function comes from. The md5 function is a bit odd though, using powershell or the windows command line, I get a certain hash for a given file. If I run the script in git bash, I get a different hash. For these files, the hash created with git bash was the same as that on the humble bundle site. Once I figured this out, I didn't look into the issue further. I'm using mysysgit 1.7.11, I think.

After the md5sum script was figured out, I went about writing a seperate script to process soundtrack_md5s. The zip files, soundtrack_md5s, and this script were all in the same directory. Initially, I was getting an uninitialized concatenation error. It took me a while to realize that the error was due to the way soundtrack_md5s was formatted. Each line contains the game name, the zipped soundtrack file name, and the md5 hash. What I didn't recognize was that I had a empty line following each line of text, was just working off the assumption that there were no empty lines. Once I modified the text file, the error was gone.

Another error was assigning the split. Some of the problems I had with this may have resutled from the formatting of the text file. I wanted to split each line into 3 neatly named variables, but that wasn't working out, so I went with an array. I'm guessing it had something to do with the manner in which I was splitting, or the format of each line. I tried chomping each line before doing the split, to remove new line characters, also tried chomping the array after splitting, but finally ended up just chomping the hash value. I should look into understanding this properly.

After chomping, it looked like I was still having problems when I printed out text, so got a regex to remove excess spaces on the hash value. 

Once this script was working as intended, I copied the md5sum function from the md5 script that I found, and things basically work as desired. The script, when run in git bash, verifies that all of the zip files match their hash correctly.
