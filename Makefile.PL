use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Net::Whois::RIS',
    AUTHOR              => q{Alexandre Dulaunoy <adulau@foo.be>},
    VERSION_FROM        => 'lib/Net/Whois/RIS.pm',
    ABSTRACT_FROM       => 'lib/Net/Whois/RIS.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'IO::Socket' => 0,
        'Scrappy'    => 0
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Net-Whois-RIS-*' },
);
