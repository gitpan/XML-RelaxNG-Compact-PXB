use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'		 => 'XML::RelaxNG::Compact::PXB',
    'VERSION_FROM'	 => 'lib/XML/RelaxNG/Compact/PXB.pm',  
    'AUTHOR'             =>  'Maxim Grigoriev, maxim_at_fnal_dot_gov',  
    'ABSTRACT'           => 'XML RelaxNG Compact data binding',
    'PL_FILES'           => {},    
    'PREREQ_PM'		=> {
			    'XML::LibXML' => 1.61,
			    'XML::NamespaceSupport' => 1,
                            'XML::LibXML::Common'  => 0.13,
			    'XML::LibXML::XPathContext' => 0.04,
			    'Test::More' => 0, 
		            'Test::Harness' => 0,
                            'Log::Log4perl' => 0,
                            'Scalar::Util' => 0,
                            'Class::Accessor'  => 0,
                            'Class::Fields'  => 0, 
                            'POD::Credentials' => 0.03,
                            'Perl::Critic' => 0,
                            'Perl::Tidy' => 0,
                            'File::Basename' => 0,
                            'File::Path' => 0,
                            'Data::Dumper' => 0,
                            'FindBin' => 0,                           
                            'version'  => 0, 
                            'fields'  => 0, 
                            'FreezeThaw' => 0,
                            'Readonly' => 0,			    
			   },
    	  
 
     dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
     clean               => { FILES => 'XML-RelaxNG-Compact-PXB-* t/data/*' },

);

 
