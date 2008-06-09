use strict;
use warnings;

use Test::Harness;
use File::Basename;
 
BEGIN {
   unshift @INC, dirname(dirname($0)); 
};
 

if ($ARGV[0] && $ARGV[0] eq '-v') {
  $Test::Harness::Verbose = 1;
  shift @ARGV;
}

my $test_dir = dirname($0) . '/t';
Test::Harness::runtests(<$test_dir/*.t>);

