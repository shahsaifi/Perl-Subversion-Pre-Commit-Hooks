#!/usr/bin/perl

use strict;
# config section
my $minchars = 4;
my $svnlook = '/usr/bin/svnlook';

#--------------------------------------------
my $repos = $ARGV[0];
my $txn = $ARGV[1];
$\="\n";
my @comment = `$svnlook log -t "$txn" "$repos"`;
my @reviewer = ();
my @unit = ();
my @tp = ();
my @reviewer1 = ();
my @unit1 = ();
my @tp1 = ();

foreach my $line (@comment)
{
chomp($line);
@reviewer1=split(':', $line) if ($line =~/Reviewer/i);
@reviewer=split(/\s+/, $reviewer1[1]);
@unit1=split(':', $line) if ($line =~/Unit/i);
@unit=split(/\s+/, $unit1[1]);
@tp1=split(':', $line) if ($line =~/TP/i);
@tp=split(/\s+/, $tp1[1]);
}

if ( length($comment[0]) == 0 ) {
print STDERR "A comment is required!";
exit(1);
}
if ( $#reviewer == 0 ) {
 print STDERR "A code reviewer is required! e.g. Code reviewer: some text";
 exit(1);
 }
if(!($reviewer[1] =~ /\w/i))
{
 print STDERR "A code reviewer name is required! e.g. Code reviewer: some text";
 exit(1);
}
print $unit[0];
if ( $#unit == 0 ) {
 print STDERR "A Unit Test is required! e.g. Unit Test: N/A";
 exit(1);
 }
if(!($unit[1] =~ /\w/i))
{
 print STDERR "A unit test value is required! e.g. Unit Test: N/A";
 exit(1);
}
if ( $#tp == 0 ) {
 print STDERR "A Nature of TP is required! e.g. Nature of change (TP#): some text ";
 exit(1);
 }
if(!($tp[1] =~ /\w/i))
{
 print STDERR "A nature of tp value is required! e.g. Nature of change (TP#): some text";
 exit(1);
}
exit(0);
