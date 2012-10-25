package # hide from PAUSE
    utf8::all::Conflicts;

use strict;
use warnings;

use Dist::CheckConflicts
    -dist      => 'utf8::all',
    -conflicts => {
        'autodie' => '2.11',
    },
    -also => [ qw(
        Dist::CheckConflicts
        Encode
        Import::Into
        charnames
        feature
        open
        parent
        strict
        utf8
        warnings
    ) ],

;

1;
