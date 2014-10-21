#!perl
# utf8::all turns on utf8
use strict;
use warnings;

use PerlIO;
use Test::More;

# Test with it on
{
    use utf8::all;

    is length "utf8::all is MËTÁŁ", 18;

    # Test the standard handles and all newly opened handles are utf8
    ok open my $test_fh, ">", "perlio_test";
    END { unlink "perlio_test" }
    for my $fh (*STDOUT, *STDIN, *STDERR, $test_fh) {
        my @layers = PerlIO::get_layers($fh);
        ok(grep(m/utf8/, @layers), 'utf8 appears in the perlio layers')
            or diag explain { $test_fh => \@layers };
        ok(grep(m/utf-8-strict/, @layers), 'utf-8-strict appears in the perlio layers')
            or diag explain { $test_fh => \@layers };
    }
}


# And off
{
    ok open my $test_fh, ">", "perlio_test2";
    END { unlink "perlio_test2" }

    my @layers = PerlIO::get_layers($test_fh);
    ok( !grep(/utf8/, @layers), q{utf8 doesn't appear in perlio layers})
        or diag explain { $test_fh => \@layers };
    ok( !grep(m/utf-8-strict/, @layers), q{utf-8-strict doesn't appear in the perlio layers})
        or diag explain { $test_fh => \@layers };

}

done_testing;
