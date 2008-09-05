package Sleep::Resource;

use strict;
use warnings;

use Carp;

sub new {
    my $klass = shift;
    my $args = shift;

    my $self = bless { %$args }, $klass;

    return $self;
}

sub get {
    croak "No GET method implemented";
}

sub put {
    croak "No PUT method implemented";
}

sub post {
    croak "No POST method implemented";
}

sub delete {
    croak "No DELETE method implemented";
}

1;

__END__


=head1 NAME

Sleep::Handler - A Sleep resource.

=head1 DESCRIPTION

Resources are the main objects in a REST-ful application. Each thing in a
website should be represented with one Resource class.

=head1 BUGS

If you find a bug, please let the author know.

=head1 COPYRIGHT

Copyright (c) 2008 Peter Stuifzand.  All rights reserved.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.


=head1 AUTHOR

Peter Stuifzand E<lt>peter@stuifzand.euE<gt>

