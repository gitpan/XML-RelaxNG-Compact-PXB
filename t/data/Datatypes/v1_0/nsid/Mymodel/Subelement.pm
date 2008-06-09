package  Datatypes::v1_0::nsid::Mymodel::Subelement;

use strict;
use warnings;
use English qw(-no_match_vars);
use version; our $VERSION = qv("v1.0");

=head1 NAME

Datatypes::v1_0::nsid::Mymodel::Subelement  -  this is data binding class for  'subelement'  element from the XML schema namespace nsid

=head1 DESCRIPTION

Object representation of the subelement element of the nsid XML namespace.
Object fields are:


    Scalar:     value,
    Scalar:     type,
    Scalar:     port,


The constructor accepts only single parameter, it could be a hashref with keyd  parameters hash  or DOM of the  'subelement' element
Alternative way to create this object is to pass hashref to this hash: { xml => <xml string> }
Please remeber that namesapce prefix is used as namespace id for mapping which not how it was intended by XML standard. The consequence of that
is if you serve some XML on one end of the webservices piepline then the same namespace prefixes MUST be used on ther one for the same namespace URNs.
This constraint can be fixed in the future releases.

Note: this class utilizes L<Log::Log4perl> module, see corresponded docs on CPAN.

=head1 SYNOPSIS

          use Datatypes::v1_0::nsid::Mymodel::Subelement;
          use Log::Log4perl qw(:easy);

          Log::Log4perl->easy_init();

          my $el =  Datatypes::v1_0::nsid::Mymodel::Subelement->new($DOM_Obj);

          my $xml_string = $el->asString();

          my $el2 = Datatypes::v1_0::nsid::Mymodel::Subelement->new({xml => $xml_string});


          see more available methods below


=head1   METHODS

=cut


use XML::LibXML;
use Scalar::Util qw(blessed);
use Log::Log4perl qw(get_logger);
use Readonly;
    
use Datatypes::v1_0::Element qw(getElement);
use Datatypes::v1_0::NSMap;
use fields qw(nsmap idmap LOGGER value type port   text );


=head2 new({})

 creates   object, accepts DOM with element's tree or hashref to the list of
 keyd parameters:

         value   => undef,
         type   => undef,
         port   => undef,
 text => 'text'

returns: $self

=cut

Readonly::Scalar our $COLUMN_SEPARATOR => ':';
Readonly::Scalar our $CLASSPATH =>  'Datatypes::v1_0::nsid::Mymodel::Subelement';
Readonly::Scalar our $LOCALNAME => 'subelement';

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
 returns subelement object DOM

=cut

sub getDOM {
    my ($self, $parent) = @_;
    my $subelement;
    eval {
         $subelement = getElement({name =>   $LOCALNAME, parent => $parent , ns  => [$self->get_nsmap->mapname($LOCALNAME)],
                               attributes => [


                                               ['value' =>  $self->get_value],

                                               ['type' =>  $self->get_type],

                                               ['port' =>  $self->get_port],

                                           ],
                                      'text' => (!($self->get_value)?$self->get_text:undef),

                               });
    };
    if($EVAL_ERROR) {
         $self->get_LOGGER->logdie(" Failed at creating DOM: $EVAL_ERROR");
    }
      return $subelement;
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



=head2 get_value

 accessor  for value, assumes hash based class

=cut

sub get_value {
    my($self) = @_;
    return $self->{value};
}

=head2 set_value

mutator for value, assumes hash based class

=cut

sub set_value {
    my($self,$value) = @_;
    if($value) {
        $self->{value} = $value;
    }
    return   $self->{value};
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



=head2 get_port

 accessor  for port, assumes hash based class

=cut

sub get_port {
    my($self) = @_;
    return $self->{port};
}

=head2 set_port

mutator for port, assumes hash based class

=cut

sub set_port {
    my($self,$value) = @_;
    if($value) {
        $self->{port} = $value;
    }
    return   $self->{port};
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


    return $query;
}



=head2  buildIdMap()

 if any of subelements has id then get a map of it in form of
 hashref to { element}{id} = index in array and store in the idmap field

=cut

sub  buildIdMap {
    my $self = shift;
    my %map = ();

    
    return;
}


=head2  asString()

 shortcut to get DOM and convert into the XML string
 
 returns nicely formatted XML string  representation of the  subelement object

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

    return $nsids;
}


=head2  fromDOM ($)

 accepts parent XML DOM  element  tree as parameter
 returns subelement  object

=cut

sub fromDOM {
    my ($self, $dom) = @_;


    $self->set_value($dom->getAttribute('value')) if($dom->getAttribute('value'));

     $self->get_LOGGER->debug(" Attribute value= ". $self->get_value) if $self->get_value;
    $self->set_type($dom->getAttribute('type')) if($dom->getAttribute('type'));

     $self->get_LOGGER->debug(" Attribute type= ". $self->get_type) if $self->get_type;
    $self->set_port($dom->getAttribute('port')) if($dom->getAttribute('port'));

     $self->get_LOGGER->debug(" Attribute port= ". $self->get_port) if $self->get_port;
    $self->set_text($dom->textContent) if(!($self->get_value) && $dom->textContent);

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


