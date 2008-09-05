package Sleep::Routes;

use strict;
use warnings;

sub new {
    my $klass  = shift;
    my $routes = shift;

    die "Not an ARRAY" unless ref($routes) eq 'ARRAY';

    my $self = bless {
        routes => $routes,
    }, $klass;

    return $self;
}


sub parse_url {
    my $self = shift;
    my $url  = shift;

    for (@{$self->{routes}}) {
        if (my (@vars) = $url =~ m/$_->{route}/) {
            return ($_, @vars);
        }
    }

    return;
}

sub resource {
    my $self = shift;
    my $url  = shift;

    my ($route, @vars) = $self->parse_url($url);
    return ($route, @vars);
}

1;

__END__


=head1 NAME

Sleep::Routes - From URI to classname.

=head1 DESCRIPTION

=head1 BUGS

If you find a bug, please let the author know.

=head1 COPYRIGHT

Copyright (c) 2008 Peter Stuifzand.  All rights reserved.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.


=head1 AUTHOR

Peter Stuifzand E<lt>peter@stuifzand.euE<gt>

