use inc::Module::Install;

name             'XML-RelaxNG-Compact-PXB';
author_from      'lib/XML/RelaxNG/Compact/PXB.pm';

license          'Fermitools';
version          '0.01';
perl_version     '5.0061';
all_from 	 'lib/';

 
requires  'XML::LibXML' => '1.55';
requires  'XML::NamespaceSupport' => '1';
requires  'XML::LibXML::Common'  => '0.13';
requires  'Test::More' => 0;

requires  'Test::Harness' => 0;
requires  'Log::Log4perl' => 0;
requires  'Scalar::Util' => 0;
requires  'Class::Accessor'  => 0;
requires  'Class::Fields'  => 0; 
 
requires  'POD::Credentials' => '0.02';
requires  'Perl::Critic' => 0;
requires  'Perl::Tidy' => 0;
requires  'File::Basename' => 0;
requires  'File::Path' => 0;
 
requires  'Data::Dumper' => 0;
requires  'FindBin' => 0; 
requires  'base'  => 0; 
requires  'version'  => 0; 
requires  'fields'  => 0; 
 
requires  'FreezeThaw' => 0;
requires  'Readonly' => 0;
 
 
requires_external_bin 'xml2-config';

no_index directory  => 't';
 

auto_install;
WriteAll;
