use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'PXB',
    AUTHOR              => 'Maxim Grigoriev <maxim@fnal.gov>',
    VERSION_FROM        => 'lib/XML/RelaxNG/Compact/PXB.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
	'Class::Accessor::Fast' => 0,
	'POD::Credentials' => 0,
	'Perl::Critic' => 0,
	'Perl::Tidy' => 0,
        'Class::Fields' => 0,	 
	'XML::LibXML' =>  '1.6', 
	'Scalar::Util' => 0,
	'Readonly' => 0,
	'Log::Log4perl' => 0,
	'FreezeThaw' => 0,
	'Test::Harness' => 0,
	'File::Basename' => 0,
	'File::Path' => 0,
	'fields' => 0,
	'version' => 0,
	'Data::Dumper' => 0,
	'FindBin' => 0, 

    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'PXB-*' },
);
