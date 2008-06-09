

use warnings;
use strict;
use Test::More;
use Data::Dumper; 
use FindBin qw($Bin);  
use Log::Log4perl qw(:easy :levels); 
use Perl::Critic;
use FreezeThaw qw(cmpStr);
use English qw( -no_match_vars);

## see BEGIN block at the bottom for the number of tests and use_ok package check

Log::Log4perl->easy_init($ERROR);   


#2
my $critic = Perl::Critic->new(-severity => "cruel", -profile => "/mnt/disk1/home/netadmin/CPAN_DISTR/XML-RelaxNG-Compact-PXB-0.03/t/data/t/conf/perlcritic");
my @problems = $critic->critique("/mnt/disk1/home/netadmin/CPAN_DISTR/XML-RelaxNG-Compact-PXB-0.03/t/data/Datatypes/v1_0/nsid/Mymodel/Subelement.pm");
ok(!@problems , " perl critic have not found any problems") or diag(" perl critic found problems:" . (join "\n" , @problems));
#3
can_ok(Datatypes::v1_0::nsid::Mymodel::Subelement->new(), qw/get_value get_type get_port/);


my $obj1 = undef;

#4
eval {
    $obj1 = Datatypes::v1_0::nsid::Mymodel::Subelement->new({
    
  'value' =>  'value_value',  'type' =>  'value_type',  'port' =>  'value_port',    })
};
ok($obj1 && !$EVAL_ERROR, "Create object Datatypes::v1_0::nsid::Mymodel::Subelement...") or diag($EVAL_ERROR);
 undef $EVAL_ERROR;
#5
my $ns  =  $obj1->get_nsmap->mapname('subelement');
ok($ns eq 'nsid', "  mapname('subelement')...  ");
#6
my $value  =  $obj1->get_value;
ok($value eq 'value_value', "Checking accessor  obj1->get_value ...  ") or diag(' Accessor test failed ');
#7
my $type  =  $obj1->get_type;
ok($type eq 'value_type', "Checking accessor  obj1->get_type ...  ") or diag(' Accessor test failed ');
#8
my $port  =  $obj1->get_port;
ok($port eq 'value_port', "Checking accessor  obj1->get_port ...  ") or diag(' Accessor test failed ');
#9
my $string;
eval {
    $string = $obj1->asString
};
ok($string && !$EVAL_ERROR, "Converting to XML string: $string") or diag($EVAL_ERROR);
undef $EVAL_ERROR;
#10
my $obj22;
eval {
    $obj22 = Datatypes::v1_0::nsid::Mymodel::Subelement->new({xml => $string});
};
ok($obj22 && !$EVAL_ERROR, "Re-create object from XML string: ") or diag($EVAL_ERROR);
undef $EVAL_ERROR;
#11
my $dom1 = $obj1->getDOM();
my $obj2;
eval {
     $obj2 = Datatypes::v1_0::nsid::Mymodel::Subelement->new($dom1);
};
ok($obj2 && !$EVAL_ERROR, "Re-create object from DOM XML: ") or diag($EVAL_ERROR);
undef $EVAL_ERROR;


BEGIN {

   plan tests =>  11;
   use_ok  'Datatypes::v1_0::nsid::Mymodel::Subelement';
  
}

1;
    
