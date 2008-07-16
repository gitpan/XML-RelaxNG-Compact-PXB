package MyBase;
use strict;
use warnings;
use Exporter ();
use base qw/Exporter/;
our @EXPORT_OK = qw/$extended $base_parameter $parameters/;

 
our($base_parameter, $parameters);
$base_parameter = {attrs  => {name => 'enum:name1,name2',  value => 'scalar',  xmlns => 'nsid'},
		   elements => [],
        	   text => 'unless:value',
        	 }; 
		 

# addExtra is closure based callback
sub addExtra {  
    my $extras = [[$base_parameter]];
    return sub {
                push @{$extras}, [@_] if @_;
	        return $extras
	       }
}
# define $parameters with $extended placeholder for adding extra variations of the parameter
our $extended =  addExtra();
$parameters   =  {attrs  => { xmlns => 'nsid'},
		  elements => [
        			[parameter =>  $extended->()],
        		      ],
        	 };
 
 	     
		     
package  ExtendedBase1;
use strict;
use warnings;
use Exporter ();
use  base  qw/Exporter MyBase/;

our @EXPORT_OK =  qw/$extended   $parameters/;

### notice different namespace, if you set the same one it will overwrite the former one.
$extended->({attrs  => {ext_name => 'scalar',  ext_value => 'scalar',  xmlns => 'nsid1'},
		   elements => [],
        	   text => 'unless:ext_value',
        	 }); 

package  ExtendedBase2;
use strict;
use warnings;
use Exporter ();
use base  qw/Exporter ExtendedBase1/; 
our @EXPORT_OK =  qw/$extended  $parameters/;

### notice different namespace, if you set the same one it will overwrite the former one.
$extended->({attrs  => {another_name => 'scalar',  another_value => 'scalar',  xmlns => 'nsid2'},
		   elements => [],
        	   text => 'unless:another_value',
        	 }); 

package main;
 
use strict;
use warnings;
use Data::Dumper;
use POD::Credentials;
use XML::RelaxNG::Compact::PXB;
use base qw/ExtendedBase2/; 
 
## adding some sql mapping for base_parameter
$base_parameter->{sql}  = { tableName => { field1 => { value => ['value' , 'text'],
                                                  if => 'name:name1'
                                                },
                                       field2 => { value => ['value' , 'text'], 
                                                  if => 'name:name2'},
                                    }    
		     };  
#
# creating API
#
 
print Dumper  $parameters;
 
my $api_builder =  XML::RelaxNG::Compact::PXB->new({
             		                             top_dir =>   './',
             		                             datatypes_root =>   "XMLTypes",
             		                             nsregistry => { 'nsid1' => 'http://some.org/nsURI'}, 
             		                             schema_version =>   '1.0', 
             		                             test_dir =>   't',	  
             		                             footer => POD::Credentials->new({author=> 'Joe Doe'}),
             				           });
 
$api_builder->buildAPI('myParameters', $parameters);

1;
