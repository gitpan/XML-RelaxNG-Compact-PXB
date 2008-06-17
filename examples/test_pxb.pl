use utf8;
use strict;
use warnings;

use POD::Credentials;
use XML::RelaxNG::Compact::PXB;

my $parameter =  { attrs => { name => 'enum:name1,name2', 
                              value => 'scalar',		
                              xmlns => 'nsid1'
                            },				
		   elements => [],
	 	   text => 'unless:value'
                 };

$parameter->{sql}  = { tableName => { field1 => { value => ['value' , 'text'],
                                                  if => 'name:name1'
                                                },
                                      field2 => { value => ['value' , 'text'], 
                                                  if => 'name:name2'},
                                    }    
		     };  
#
# create API
#
my $api_builder =  XML::RelaxNG::Compact::PXB->new({
             		                             top_dir =>   '/home/netadmin/test_dir/',
             		                             datatypes_root =>   "XMLTypes",
             		                             nsregistry => { 'nsid1' => 'http://some.org/nsURI'}, 
             		                             schema_version =>   '1.0', 
             		                             test_dir =>   't',	  
             		                             footer => POD::Credentials->new({author=> 'Joe Doe'}),
             				           });

$api_builder->buildAPI('myParameter', $parameter);

