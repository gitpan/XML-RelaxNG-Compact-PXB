use strict;
use warnings;

#
#  for those Test::Harness lovers out there
#
use Test::Harness;
use File::Basename;
 
BEGIN {
   unshift @INC, dirname(dirname($0)) . '/t/lib';
   unshift @INC, dirname(dirname($0)) . '/t/data';
};
 

if ($ARGV[0] && $ARGV[0] eq '-v') {
  $Test::Harness::Verbose = 1;
  shift @ARGV;
}

my $test_dir = dirname($0) . '/t';
Test::Harness::runtests(<$test_dir/data/t/*.t>);
