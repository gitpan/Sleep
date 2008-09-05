package Sleep::Handler;

use strict;
use warnings;

use Apache2::RequestRec;
use Apache2::Const qw/OK HTTP_METHOD_NOT_ALLOWED HTTP_OK HTTP_SEE_OTHER HTTP_NO_CONTENT/;
use Apache2::RequestIO ();
use APR::Table;

use CGI::Simple;

use Sleep::Request;
use Sleep::Routes;

sub BUILD {
    my ($klass, $db, $routes) = @_;
    return bless { db => $db, routes => $routes }, $klass;
}

sub read_post {
    my ($r) = @_;

    my $str = '';
    my $buf = '';
    
    while ($r->read($buf, 1024) >= 1024) {
        $str .= $buf;
    }
    return $str;
}

sub handler : method {
    my $self = shift;
    my $r    = shift;

    my $db     = $self->{db};
    my $routes = $self->{routes};

    my $cgi    = CGI::Simple->new();

    my ($route, @vars) = $routes->resource($r->uri());

    eval "require $route->{class}";

    if ($@) {
        die "Can't load '$route->{class}': $@";
    }

    my $resource = $route->{class}->new({db => $db});

    my $request = Sleep::Request->new($r, $db, @vars);

    my $method = lc $r->method();

    my $mime_type = 'application/json';

    if ($method =~ m/^get|post|put|delete$/) {
        if ($method eq 'get') {
            my $response = $resource->get($request);
            $r->content_type($mime_type);
            $r->print($response->encode($mime_type));
            return Apache2::Const::OK;
        }
        elsif ($method eq 'post') {
            my $postdata = $cgi->param('POSTDATA');
            $request->decode($postdata);
            my $response = $resource->post($request);

            $r->content_type($mime_type);
            $r->status(Apache2::Const::HTTP_SEE_OTHER);
            $r->headers_out->{Location} = $response->location();
            return Apache2::Const::OK;
        }
        elsif ($method eq 'put') {
            my $postdata = $cgi->param('PUTDATA');
            $request->decode($postdata);
            my $response = $resource->put($request);
            $r->status(Apache2::Const::HTTP_OK);
            $r->content_type($mime_type);
            $r->print($response->encode($mime_type));
            return Apache2::Const::OK;
        }
        elsif ($method eq 'delete') {
            my $response = $resource->delete($request);
            $r->status(Apache2::Const::HTTP_NO_CONTENT);
            return Apache2::Const::OK;
        }
    }

    return Apache2::Const::HTTP_METHOD_NOT_ALLOWED;
}

1;

__END__


=head1 NAME

Sleep::Handler - ModPerl handler for Sleep.

=head1 DESCRIPTION

=head1 BUGS

If you find a bug, please let the author know.

=head1 COPYRIGHT

Copyright (c) 2008 Peter Stuifzand.  All rights reserved.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.


=head1 AUTHOR

Peter Stuifzand E<lt>peter@stuifzand.euE<gt>

