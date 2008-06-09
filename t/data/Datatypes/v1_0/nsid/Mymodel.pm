package  Datatypes::v1_0::nsid::Mymodel;

use strict;
use warnings;
use English qw(-no_match_vars);
use version; our $VERSION = qv("v1.0");

=head1 NAME

Datatypes::v1_0::nsid::Mymodel  -  this is data binding class for  'mymodel'  element from the XML schema namespace nsid

=head1 DESCRIPTION

Object representation of the mymodel element of the nsid XML namespace.
Object fields are:


    Scalar:     type,
    Scalar:     id,
    Object reference:   subelement => type HASH,


The constructor accepts only single parameter, it could be a hashref with keyd  parameters hash  or DOM of the  'mymodel' element
Alternative way to create this object is to pass hashref to this hash: { xml => <xml string> }
Please remeber that namesapce prefix is used as namespace id for mapping which not how it was intended by XML standard. The consequence of that
is if you serve some XML on one end of the webservices piepline then the same namespace prefixes MUST be used on ther one for the same namespace URNs.
This constraint can be fixed in the future releases.

Note: this class utilizes L<Log::Log4perl> module, see corresponded docs on CPAN.

=head1 SYNOPSIS

          use Datatypes::v1_0::nsid::Mymodel;
          use Log::Log4perl qw(:easy);

          Log::Log4perl->easy_init();

          my $el =  Datatypes::v1_0::nsid::Mymodel->new($DOM_Obj);

          my $xml_string = $el->asString();

          my $el2 = Datatypes::v1_0::nsid::Mymodel->new({xml => $xml_string});


          see more available methods below


=head1   METHODS

=cut


use XML::LibXML;
use Scalar::Util qw(blessed);
use Log::Log4perl qw(get_logger);
use Readonly;
    
use Datatypes::v1_0::Element qw(getElement);
use Datatypes::v1_0::NSMap;
use Datatypes::v1_0::nsid::Mymodel::Subelement;
use fields qw(nsmap idmap LOGGER type id subelement );


=head2 new({})

 creates   object, accepts DOM with element's tree or hashref to the list of
 keyd parameters:

         type   => undef,
         id   => undef,
         subelement => HASH,

returns: $self

=cut

Readonly::Scalar our $COLUMN_SEPARATOR => ':';
Readonly::Scalar our $CLASSPATH =>  'Datatypes::v1_0::nsid::Mymodel';
Readonly::Scalar our $LOCALNAME => 'mymodel';

sub new {
    my ($that, $param) = @_;

    my $class = ref($that) || $that;
    my $self =  fields::new($class );
    $self->set_LOGGER(get_logger( $CLASSPATH ));
    $self->set_nsmap(Datatypes::v1_0::NSMap->new());
    $self->get_nsmap->mapname($LOCALNAME, 'nsid');



    if($param) {
        if(blessed $param && $param->can('getName')  && ($param->getName =~ m/$LOCALNAME$/xm) ) {
            return  $self->fromDOM($param);
        } elsif(ref($param) ne 'HASH')   {
            $self->get_LOGGER->logdie("ONLY hash ref accepted as param " . $param );
            return;
        }
        if($param->{xml}) {
            my $parser = XML::LibXML->new();
            my $dom;
            eval {
                my $doc = $parser->parse_string($param->{xml});
                $dom = $doc->getDocumentElement;
            };
            if($EVAL_ERROR) {
                $self->get_LOGGER->logdie(" Failed to parse XML :" . $param->{xml} . " \n ERROR: \n" . $EVAL_ERROR);
                return;
            }
            return  $self->fromDOM($dom);
        }
        $self->get_LOGGER->debug("Parsing parameters: " . (join ' : ', keys %{$param}));


        foreach my $param_key (keys %{$param}) {
            $self->{$param_key} = $param->{$param_key} if $self->can("get_$param_key");
        }
        $self->get_LOGGER->debug("Done");
    }
    return $self;
}

=head2   getDOM ($parent)

 accepts parent DOM  serializes current object into the DOM, attaches it to the parent DOM tree and
 returns mymodel object DOM

=cut

sub getDOM {
    my ($self, $parent) = @_;
    my $mymodel;
    eval {
         $mymodel = getElement({name =>   $LOCALNAME, parent => $parent , ns  => [$self->get_nsmap->mapname($LOCALNAME)],
                               attributes => [


                                               ['type' =>  $self->get_type],

                                               ['id' =>  $self->get_id],

                                           ],
                               });
    };
    if($EVAL_ERROR) {
         $self->get_LOGGER->logdie(" Failed at creating DOM: $EVAL_ERROR");
    }

    if($self->get_subelement && blessed $self->get_subelement && $self->get_subelement->can("getDOM")) {
        my $subelementDOM = $self->get_subelement->getDOM($mymodel);
        $subelementDOM?$mymodel->appendChild($subelementDOM):$self->get_LOGGER->logdie("Failed to append  subelement element with value:" .  $subelementDOM->toString);
    }

      return $mymodel;
}


=head2 get_LOGGER

 accessor  for LOGGER, assumes hash based class

=cut

sub get_LOGGER {
    my($self) = @_;
    return $self->{LOGGER};
}

=head2 set_LOGGER

mutator for LOGGER, assumes hash based class

=cut

sub set_LOGGER {
    my($self,$value) = @_;
    if($value) {
        $self->{LOGGER} = $value;
    }
    return   $self->{LOGGER};
}



=head2 get_nsmap

 accessor  for nsmap, assumes hash based class

=cut

sub get_nsmap {
    my($self) = @_;
    return $self->{nsmap};
}

=head2 set_nsmap

mutator for nsmap, assumes hash based class

=cut

sub set_nsmap {
    my($self,$value) = @_;
    if($value) {
        $self->{nsmap} = $value;
    }
    return   $self->{nsmap};
}



=head2 get_idmap

 accessor  for idmap, assumes hash based class

=cut

sub get_idmap {
    my($self) = @_;
    return $self->{idmap};
}

=head2 set_idmap

mutator for idmap, assumes hash based class

=cut

sub set_idmap {
    my($self,$value) = @_;
    if($value) {
        $self->{idmap} = $value;
    }
    return   $self->{idmap};
}



=head2 get_text

 accessor  for text, assumes hash based class

=cut

sub get_text {
    my($self) = @_;
    return $self->{text};
}

=head2 set_text

mutator for text, assumes hash based class

=cut

sub set_text {
    my($self,$value) = @_;
    if($value) {
        $self->{text} = $value;
    }
    return   $self->{text};
}



=head2 get_type

 accessor  for type, assumes hash based class

=cut

sub get_type {
    my($self) = @_;
    return $self->{type};
}

=head2 set_type

mutator for type, assumes hash based class

=cut

sub set_type {
    my($self,$value) = @_;
    if($value) {
        $self->{type} = $value;
    }
    return   $self->{type};
}



=head2 get_id

 accessor  for id, assumes hash based class

=cut

sub get_id {
    my($self) = @_;
    return $self->{id};
}

=head2 set_id

mutator for id, assumes hash based class

=cut

sub set_id {
    my($self,$value) = @_;
    if($value) {
        $self->{id} = $value;
    }
    return   $self->{id};
}



=head2 get_subelement

 accessor  for subelement, assumes hash based class

=cut

sub get_subelement {
    my($self) = @_;
    return $self->{subelement};
}

=head2 set_subelement

mutator for subelement, assumes hash based class

=cut

sub set_subelement {
    my($self,$value) = @_;
    if($value) {
        $self->{subelement} = $value;
    }
    return   $self->{subelement};
}



=head2  querySQL ()

 depending on SQL mapping decalration it will return some hash ref  to the  decalred fields
 for example querySQL ()
 
 Accepts one optional parameter - query hashref, it will fill this hashref
 
 will return:
    
    { <table_name1> =>  {<field name1> => <value>, ...},...}

=cut

sub  querySQL {
    my ($self, $query) = @_;




    foreach my $subname (qw/subelement/) {
        if($self->{$subname} && (ref($self->{$subname}) eq 'ARRAY' ||  blessed $self->{$subname})) {
            my @array = ref($self->{$subname}) eq 'ARRAY'?@{$self->{$subname}}:($self->{$subname});
            foreach my $el (@array) {
                if(blessed $el && $el->can('querySQL'))  {
                    $el->querySQL($query);
                    $self->get_LOGGER->debug("Quering mymodel  for subclass $subname");
                } else {
                    $self->get_LOGGER->logdie("Failed for mymodel Unblessed member or querySQL is not implemented by subclass $subname");
                }
           }
        }
    }
         
    return $query;
}



=head2  buildIdMap()

 if any of subelements has id then get a map of it in form of
 hashref to { element}{id} = index in array and store in the idmap field

=cut

sub  buildIdMap {
    my $self = shift;
    my %map = ();

    


    foreach my $field (qw/subelement/) {
        my @array = ref($self->{$field}) eq 'ARRAY'?@{$self->{$field}}:($self->{$field});
        my $i = 0;
        foreach my $el (@array)  {
            if($el && blessed $el && $el->can('get_id') &&  $el->get_id)  {
                $map{$field}{$el->get_id} = $i;
            }
            $i++;
        }
    }
    return $self->set_idmap(\%map);
        
}


=head2  asString()

 shortcut to get DOM and convert into the XML string
 
 returns nicely formatted XML string  representation of the  mymodel object

=cut

sub asString {
    my $self = shift;
    my $dom = $self->getDOM();
    return $dom->toString('1');
}

=head2 registerNamespaces ()

 will parse all subelements
 returns reference to hash with namespace prfixes
 
 most parsers are expecting to see namespace registration info in the document root element declaration

=cut

sub registerNamespaces {
    my ($self, $nsids) = @_;

    my $local_nss = {reverse %{$self->get_nsmap->mapname}};
    unless($nsids) {
        $nsids = $local_nss;
    }  else {
        %{$nsids} = (%{$local_nss}, %{$nsids});
    }



    foreach my $field (qw/subelement/) {
        my @array = ref($self->{$field}) eq 'ARRAY'?@{$self->{$field}}:($self->{$field});
        foreach my $el (@array) {
            if(blessed $el &&  $el->can('registerNamespaces') ) {
                my $fromNSmap = $el->registerNamespaces($nsids);
                my %ns_idmap = %{$fromNSmap};
                foreach my $ns (keys %ns_idmap)  {
                    $nsids->{$ns}++;
                }
            }
        }
    }

    return $nsids;
}


=head2  fromDOM ($)

 accepts parent XML DOM  element  tree as parameter
 returns mymodel  object

=cut

sub fromDOM {
    my ($self, $dom) = @_;


    $self->set_type($dom->getAttribute('type')) if($dom->getAttribute('type'));

     $self->get_LOGGER->debug(" Attribute type= ". $self->get_type) if $self->get_type;
    $self->set_id($dom->getAttribute('id')) if($dom->getAttribute('id'));

     $self->get_LOGGER->debug(" Attribute id= ". $self->get_id) if $self->get_id;
     foreach my $childnode ($dom->childNodes) {
         my  $getname  = $childnode->getName;
         my ($nsid, $tagname) = split $COLUMN_SEPARATOR, $getname;
         next unless($nsid && $tagname);
         if ($tagname eq  'subelement' && $nsid eq 'nsid' && $self->can("get_$tagname")) {
             my $element = undef;
             eval {
                 $element = Datatypes::v1_0::nsid::Mymodel::Subelement->new($childnode)
             };
             if($EVAL_ERROR || !($element  && blessed $element)) {
                 $self->get_LOGGER->logdie(" Failed to load and add  Subelement : " . $dom->toString . " error: " . $EVAL_ERROR);
                 return;
             }
           $self->set_subelement($element); ### add another subelement  
         } 
     }
     $self->buildIdMap;
    $self->registerNamespaces;
    return $self;
}


1;

__END__


=head1  SEE ALSO

Automatically generated by L<XML::RelaxNG::Compact::PXB> 

=head1 AUTHOR

Joe Doe

=head1 COPYRIGHT

Copyright (c) 2008, Joe Doe. All rights reserved.

=head1 LICENSE

This program is free software.
You can redistribute it and/or modify it under the same terms as Perl itself.

=cut


