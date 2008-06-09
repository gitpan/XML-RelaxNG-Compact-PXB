

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


use_ok 'Datatypes::v1_0::nsid::Mymodel::Subelement';
#2
#3
my $critic = Perl::Critic->new(-severity => "cruel", -profile => "/mnt/disk1/home/netadmin/CPAN_DISTR/XML-RelaxNG-Compact-PXB-0.03/t/data/t/conf/perlcritic");
my @problems = $critic->critique("/mnt/disk1/home/netadmin/CPAN_DISTR/XML-RelaxNG-Compact-PXB-0.03/t/data/Datatypes/v1_0/nsid/Mymodel.pm");
ok(!@problems , " perl critic have not found any problems") or diag(" perl critic found problems:" . (join "\n" , @problems));
#4
can_ok(Datatypes::v1_0::nsid::Mymodel->new(), qw/get_type get_id get_subelement/);


my $obj1 = undef;

#5
eval {
    $obj1 = Datatypes::v1_0::nsid::Mymodel->new({
    
  'type' =>  'value_type',  'id' =>  'value_id',    })
};
ok($obj1 && !$EVAL_ERROR, "Create object Datatypes::v1_0::nsid::Mymodel...") or diag($EVAL_ERROR);
 undef $EVAL_ERROR;
#6
my $ns  =  $obj1->get_nsmap->mapname('mymodel');
ok($ns eq 'nsid', "  mapname('mymodel')...  ");
#7
my $type  =  $obj1->get_type;
ok($type eq 'value_type', "Checking accessor  obj1->get_type ...  ") or diag(' Accessor test failed ');
#8
my $id  =  $obj1->get_id;
ok($id eq 'value_id', "Checking accessor  obj1->get_id ...  ") or diag(' Accessor test failed ');
#9
my $obj_subelement;
eval {
    $obj_subelement = Datatypes::v1_0::nsid::Mymodel::Subelement->new({  'value' =>  'valuevalue',  'type' =>  'valuetype',  'port' =>  'valueport',    });
    $obj1->set_subelement($obj_subelement);
};
ok($obj_subelement && !$EVAL_ERROR, "Create subelement object subelement and set it") or diag($EVAL_ERROR);
undef $EVAL_ERROR;
#10
my $string;
eval {
    $string = $obj1->asString
};
ok($string && !$EVAL_ERROR, "Converting to XML string: $string") or diag($EVAL_ERROR);
undef $EVAL_ERROR;
#11
my $obj22;
eval {
    $obj22 = Datatypes::v1_0::nsid::Mymodel->new({xml => $string});
};
ok($obj22 && !$EVAL_ERROR, "Re-create object from XML string: ") or diag($EVAL_ERROR);
undef $EVAL_ERROR;
#12
my $dom1 = $obj1->getDOM();
my $obj2;
eval {
     $obj2 = Datatypes::v1_0::nsid::Mymodel->new($dom1);
};
ok($obj2 && !$EVAL_ERROR, "Re-create object from DOM XML: ") or diag($EVAL_ERROR);
undef $EVAL_ERROR;


BEGIN {

   plan tests =>  12;
   use_ok  'Datatypes::v1_0::nsid::Mymodel';
  
}

1;
    
