use strict;
use warnings;
use version 0.77;
use Test::More tests => 1;

if ( eval { require autodie; 1 } ) {
    diag "autodie is version $autodie::VERSION, but must be greater than version 2.11"
        if (version->parse($autodie::VERSION) < version->parse(2.11));
}
pass;