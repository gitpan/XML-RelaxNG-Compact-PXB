package   XML::RelaxNG::Compact::DataModel;
 
use strict;
use warnings;
use version; our $VERSION = '0.03';  

=head1 NAME

XML::RelaxNG::Compact::DataModel -  RelaxNG Compact L<http://relaxng.org/compact-tutorial-20030326.html>
                                     schema  expressed in perl

=head1 VERSION

Version 0.03 

=head1 DESCRIPTION

This is a user's guide module for documentation only. It describes the perlish expression of 
the  RelaxNG Compact schema.  Some limitations are: 

=over

=item  * there is no datatyping,


=item  *  there is no support for minLength,maxLength xsd:string constraints, although conditional logic is supported


=item  * there is no support for annotations


=item  * support for includes and C<inherit> are provided by the data model developer, means you can split your model in different 
          packages and inherit it. Just remember that PXB deals with references to hashes and arrays. See below.


=back

Everything else can be expressed by perl constructs and will be supported by the created API.
Every element from the schema can be expressed as perl hash reference:

=over

    <element-variable>  =  '{ attrs => {' <attributes-definition> ', '  
                                        'xmlns  => ' <namespace-prefix> '},'   
 				        'elements  =>  [' <elements-definition> '],'   
 				        'text   =>' <text-content> ','   
 				        'sql => {' <sql-mapping-definition or any other mapping to external data model> '}'   
 			      '}'    

=back

Where each <xxxx-definition> can be expressed in EBNF  as:

=over

    <attributes-definition>  = (attribute-name  '=>'  attribute-value) ( ','  <attributes-definition>)*	

    attribute-name = string   

    namespace-id = string   

    attribute-value  = 'scalar' | ('enum:'(attribute-name ( ','  attribute-name)*))    

    <elements-definition> =   ( '[' element-name  '=>'  (   
 						              <element-variable>  |
                                                    ’'['   ‘   <element-variable> '’]’' | 
                                                    ’'[‘' (    <element-variable> '’,'’)+’ ']’' |
                                                    '’[‘' ('['‘ <element-variable> '’]’,'’?)+ ’']'’ ) 
                                                   ',' conditional-statement? ']’')*

     conditional-statement =  ('unless'|'if')':'(registered-name (',' registered-name)*)   

     registered-name = attribute-name|element-name   

     element-name  = string   

     <text-content> = 'scalar'|conditional-statement   

     <sql-mapping-definition> = (sql-table-name '=> {' sql-table-entry '}' ) ( ',' <sql-mapping-definition>)*   

     sql-table-entry =  (sql-entry-name '=> {' entry-mapping '}' ) ( ','   sql-table-entry )*   

     sql-table-name = string

     sql-entry-name = string   

     entry-mapping = 'value' '=>'( element-name|( '[' element-name (',' element-name)+ ']')) ( ',' if-condition)?     

     if-condition = 'if =>' attribute-name ':' attribute-value	

=back

In the attributes definition the xmlns attribute is reserved for the namespace prefix.
This name must be registered within Namespace class in order to provide some level of validation. 
This constraint will be fixed in future releases.
Its recommended to have unique C<id> attribute in each element, it will allow to utilize mapping by C<id> for the complex element types.

There is some conditional logic allowed for attributes. An attribute value can be scalar which stays 
for C<scalar> string or enumerated list of the allowed names. The list of  elements 
is represented as array reference. The choice between several possible  elements 
is introduced as array reference to the list and having multiple  elements of one kind is represented 
as reference to array consisted with single element variable of that kind.

For example:

=over

=item
   
    elements => [parameter => $parameter] - defines single "parameter" sub-element

=item 
   
    elements => [parameter => [$parameter]] - defines list of "parameter" sub-elements

=item 

    elements => [parameters => [$parameters, $select_parameters]] - defines choice between 
                two single "parameters" sub-elements of different type

=item 
   
    elements => [datum => [[$pinger_datum],[$result_datum]] ] - defines choice between two
                lists of "datum" sub-elements of different type 

=back

In C<elements-definition> the third member is an optional conditional statement which represents validation rule.
For example C<unless:value> conditional statement will be translated into the perl's conditional statement 
C<< && !($self->value) >> where value must be registered attribute or sub-element name and this 
condition will be placed in every piece of code where perl object is serialized into the XML DOM object or from it. 

B<Note:> You have to define element bottom-to-top in order for them to "know" about each other.
   
=head1 SYNOPSIS
      
     
      ## for example lets define some RelaxNG schema  in Compact notation and then express it as perl data structure
      #   this is a base schema from the L<http://ogf.org/schema/network/topology/base> namespace
      #
      # start =
      #  (
      #          element nmwg:message {
      #                  MessageContent
      #          } 
      #  )
      #
      #  MessageContent =
      #       Identifier? & 
      #       MessageIdentifierRef? &
      #       Type &
      #       Parameters? &                        
      #       (
      #               Metadata  
      #       )+
      #
      #  Identifier = attribute id { xsd:string }
      #
      #  IdReference =    attribute idRef { xsd:string }
      #      
      #  Type = attribute type { xsd:string }   
      #  MetadataIdentifierRef = attribute metadataIdRef { xsd:string }
      #
      #  MessageIdentifierRef =  attribute messageIdRef { xsd:string }
      # 
      # Metadata = 
      #    element nmwg:metadata {
      #  	  (
      #  		  Identifier &
      #  		  MetadataIdentifierRef? &
      #  		  MetadataContent
      #  	  )
      #    }
      #
      # MetadataBlock =
      #    Parameters?
      #
      # MetadataContent = 
      #  (
      #	   MetadataBlock 	     
      #  ) &	     
      #  EventType? &
      #
      # EventType =  element nmwg:eventType { xsd:string }      
      # 
      #  Parameters = 
      #    element nmwg:parameters {
      # 	    ParametersContent
      #    }
      #  
      # ParametersContent =	 
      #	  Identifier &
      #	  Parameter+
      #  
      # Parameter =   element nmwg:parameter { 
      #  	attribute name { 
      #  			 "count" | "packetInterval" | "endTime"| 
      #  			 "packetSize" | "ttl" |  "startTime" | 
      #  			 "valueUnits"  
      #  		       } &
      #  	(
      #  		attribute value { text } |
      #  		text
      #  	)
      #   }
 

 
     $parameter	=  {attrs  => {name => 'enum:count,packetInterval,packetSize,ttl,valueUnits,startTime,endTime',  
                               value => 'scalar', 
			       xmlns => 'nmwg'},
                    elements => [],
		    text => 'unless:value',
	         }; 		 
     $parameters =  {attrs  => {id => 'scalar',   
                                xmlns => 'nmwg'},
                     elements => [
		                    [parameter => [$parameter]], 
			      
			        ], 
	           };
   
  
     $metadata = {attrs  => {id => 'scalar', metadataIdRef => 'scalar',
                             xmlns => 'nmwg'},
 	          elements => [
 			         [parameters =>   $parameters],
 			         [eventType  =>  'text'] 
			    ], 
 	        }; 

     $message  = {attrs  => {id => 'scalar', type => 'scalar', xmlns => 'nmwg'}, 
                  elements => [ 
		                 [parameters =>  [$parameters]],
		                 [metadata => [$metadata]], 
			         [data	   => [$data]]
			      ], 
	         };
     
     ## this is it, as you can see it takes much less code to express the same RelaxNG compact schema 
     ## and of course that means even less code in case of  XML schema
    

=head1 SQL MAPPING

After ( or at the time of ) defining your elements  you can set your sql mapping.
Actually, it could be mapping to any external data model.  
Lets see how we can map parameters from C<parameter> element into some fields from some SQL DB table

  # take C<$parameter> element from the previous example 

=over

       $parameter->{sql} =     
     
       #   for example this statement   will map 'count' field of the metadata table to be populated
       #  from attribute  'value' or text when attribute 'name' == 'count'
       #
       #  actually it will return this structure:
       #    metaData => { count => <value> }
       #  
       #
       
      {metaData => {count => { value =>  ['value' , 'text'], if => 'name:count'},
	
			  		 packetInterval=> { value =>  ['value' , 'text'], if => 'name:packetInterval'},
			  		 packetSize=> { value => ['value' , 'text']  , if => 'name:packetSize'},
			  		 ttl=> { value =>   ['value' , 'text'] , if => 'name:ttl'},
			  		 protocol => { value =>   ['value' , 'text'] , if => 'name:protocol'},
			  		 transport => { value =>   ['value' , 'text'] , if => 'name:transport'},
                          		 },
	 # next statement will define where to get time range 	and will return it as 'time' range data structure
	 #  for example: time => { 'ge' => '111111111', 'le' => '222222222' }
	 #  
	 # that means you absolutely free on how to use this mapping			 
			    time     => { 'ge' =>  { value =>	['value' , 'text'],  if => 'name:startTime'},
                          		  'le'  =>   { value =>  ['value' , 'text'],  if => 'name:endTime'},
                          		}, 
		            }; 

=back


=head1   DEVELOPING DATA MODELS

The best design pattern would be writing your data model by following your schema design. 
Create DataModel.pm package for the base schema and export all necessary 
data structures and then somewhere in the building script add any extra sql mapping or even redefine some elements by replacing particular 
element definitions with new data structure.  Of course you can mix elements with the same names from the different namespaces,
just name them differently but  it would be easier to define them in separate data model packages. 

=head1 AUTHOR

Maxim Grigoriev, maxim at fnal_gov

=head1 LICENSE

Fermitools license (open source, modified BSD type), see   L<http://fermitools.fnal.gov/about/terms.html>

=head1 COPYRIGHT

Copyright (C) 2007-2008 by Fermitools, Fermilab

=cut

 
1;
 
  
