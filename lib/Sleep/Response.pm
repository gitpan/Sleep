package Sleep::Response;

use strict;
use warnings;

use Carp;
use JSON::XS;

sub new {
    my $klass = shift;
    my $args = shift || {};

    my $self = bless { %$args }, $klass;

    return $self;
}

sub data {
    my $self = shift;
    return $self->{data};
}

sub location {
    my $self = shift;
    return $self->{location};
}

sub encode {
    my $self = shift;
    my $as = shift;

    if ($as eq 'application/json') {
        return encode_json($self->data());
    }
    
    croak "Can't encode";
}

1;

__END__

=head1 NAME

Sleep::Response - A Sleep response

=head1 DESCRIPTION

=head1 BUGS

If you find a bug, please let the author know.

=head1 COPYRIGHT

Copyright (c) 2008 Peter Stuifzand.  All rights reserved.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

Peter Stuifzand E<lt>peter@stuifzand.euE<gt>

