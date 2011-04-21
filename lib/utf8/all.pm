package utf8::all;
use strict;
use warnings;
use 5.010; # state
# ABSTRACT: turn on unicode. All of it.
our $VERSION = '0.002'; # VERSION


use Encode ();
use parent 'utf8';
use parent 'open';

sub import {
    my $class = shift;

    $^H{'utf8::all'} = 1;
    
    # utf8 source code
    utf8::import($class);

    # utf8 by default on filehandles
    open::import($class, ':encoding(UTF-8)');
    open::import($class, ':std');
    {
        no strict 'refs'; ## no critic (TestingAndDebugging::ProhibitNoStrict)
        *{$class . '::open'} = \&utf8_open;
    }

    #utf8 in @ARGV
    state $have_encoded_argv = 0;
    _encode_argv() unless $have_encoded_argv++;
    return;
}

sub unimport {
    $^H{'utf8::all'} = 0;
    return;
}

sub utf8_open(*;$@) {  ## no critic (Subroutines::ProhibitSubroutinePrototypes)
    my $ret;
    if( @_ == 1 ) {
        $ret = CORE::open $_[0];
    }
    else {
        $ret = CORE::open $_[0], $_[1], @_[2..$#_];
    }

    # Don't try to binmode an unopened filehandle
    return $ret unless $ret;

    my $h = (caller 1)[10];
    binmode $_[0], ':encoding(UTF-8)' if $h->{'utf8::all'};
    return $ret;
}

sub _encode_argv {
    $_ = Encode::decode('UTF-8', $_) for @ARGV;
    return;
}


1;

__END__
=pod

=encoding utf-8

=head1 NAME

utf8::all - turn on unicode. All of it.

=head1 VERSION

version 0.002

=head1 SYNOPSIS

    use utf8::all; # Turn on UTF-8. All of it.

    open my $in, '<', 'contains-utf8';  # UTF-8 already turned on here
    print length 'føø bār';             # 7 UTF-8 characters
    my $utf8_arg = shift @ARGV;         # @ARGV is UTF-8 too!

=head1 DESCRIPTION

L<utf8> allows you to write your Perl encoded in UTF-8. That means UTF-8
strings, variable names, and regular expressions. C<utf8::all> goes further, and
makes C<@ARGV> encoded in UTF-8, and filehandles are opened with UTF-8 encoding
turned on by default (including STDIN, STDOUT, STDERR). If you I<don't> want
UTF-8 for a particular filehandle, you'll have to set C<binmode $filehandle>.

The pragma is lexically-scoped, so you can do the following if you had some
reason to:

    {
        use utf8::all;
        open my $out, '>', 'outfile';
        my $utf8_str = 'føø bār';
        print length $utf8_str, "\n"; # 7
        print $out $utf8_str;         # out as utf8
    }
    open my $in, '<', 'outfile';      # in as raw
    my $text = do { local $/; <$in>};
    print length $text, "\n";         # 10, not 7!

=for Pod::Coverage utf8_open
unimport

=head1 AVAILABILITY

The project homepage is L<http://p3rl.org/utf8::all>.

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see L<http://search.cpan.org/dist/utf8-all/>.

The development version lives at L<http://github.com/doherty/utf8-all>
and may be cloned from L<git://github.com/doherty/utf8-all.git>.
Instead of sending patches, please fork this project using the standard
git and github infrastructure.

=head1 SOURCE

The development version is on github at L<http://github.com/doherty/utf8-all>
and may be cloned from L<git://github.com/doherty/utf8-all.git>

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<https://github.com/doherty/utf8-all/issues>.

=head1 AUTHORS

=over 4

=item *

Michael Schwern <mschwern@cpan.org>

=item *

Mike Doherty <doherty@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Michael Schwern <mschwern@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

