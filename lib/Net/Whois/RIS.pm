package Net::Whois::RIS;

use warnings;
use strict;
use IO::Socket;

require Exporter;
use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

our %EXPORT_TAGS = (
    'all' => [
        qw(

          )
    ]
);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT    = qw( );

sub new {

    my ($this) = @_;
    my $class = ref($this) || $this;
    my $self = {};
    bless $self, $class;
    $self->{host} = "ris.ripe.net";
    return $self;

}

sub getIPInfo {

    my ( $self, $ip ) = @_;
    my $con = IO::Socket::INET->new( PeerAddr => $self->{host}, PeerPort => 43 )
      or die();
    print $con $ip . "\n";
    my $x;
    while (<$con>) {
        $x = $x . $_;
    }
    my %h = ();
    foreach ( split( /\n/, $x ) ) {
        next if (m/^%/);
        next if (m/^$/);
        my @d = split( /:/, $_ );
        $d[1] =~ s/^\s+//;
        $h{ $d[0] } = $d[1];
    }
    $self->{get} = \%h;
    return $self;
}

sub getOrigin {
    my ($self) = @_;

    return $self->{get}{'origin'};
}

sub getDescr {
    my ($self) = @_;

    return $self->{get}{'descr'};
}

sub getRoute {
    my ($self) = @_;

    return $self->{get}{'route'};
}
1;    # End of Net::Whois::RIS
__END__

=head1 NAME

Net::Whois::RIS - Whois lookup on RIPE RIS 

=head1 VERSION

Version 0.1

=cut
our $VERSION = '0.1';

=head1 SYNOPSIS

The module query the RIPE Routing Information Service (RIS) to get
information about a specific IP address. You can get information
like the AS number announcing the IP address/network.
    
    use Net::Whois::RIS;

    my $foo = Net::Whois::RIS->new();
    $foo->getIPInfo("8.8.8.8");
    print $foo->getOrigin();
    print $foo->getDescr();

=head1 methods 

The object  oriented interface to C<Net::Whois::RIS> is  described in this
section.  

The following methods are provided:

=over 4

=item Net::Whois::RIS->new();

This constructor returns a new C<Net::Whois::RIS> object encapsulating whois
request to RIPE RIS.

=item getIPInfo($ipaddress);

The method is gathering the information from the RIS service.

=item getOrigin();

The method returns a string containing the origin of the network/IP requested.

=item getDescr();

The method returns a string containing the description of the AS announcing the network/IP requested.

=item getRoute();

The method returns a string containing the last route announced for the requested network/IP address.

=back

=head1 AUTHOR

Alexandre Dulaunoy, C<< <adulau at foo.be> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-net-whois-ris at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-Whois-RIS>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::Whois::RIS


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-Whois-RIS>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Net-Whois-RIS>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Net-Whois-RIS>

=item * Search CPAN

L<http://search.cpan.org/dist/Net-Whois-RIS/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Alexandre Dulaunoy.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut
