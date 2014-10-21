use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.08

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/utf8/all.pm',
    't/00-compile.t',
    't/ARGV.t',
    't/ARGV_twice.t',
    't/FATAL_utf8.t',
    't/autodie.t',
    't/charnames.t',
    't/fc.t',
    't/lexical-again.t',
    't/lexical.t',
    't/open.t',
    't/readdir.t',
    't/unicode_eval.t',
    't/unicode_strings.t',
    't/utf8.t'
);

notabs_ok($_) foreach @files;
done_testing;
