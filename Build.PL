
# This file was automatically generated by Dist::Zilla::Plugin::ModuleBuild v5.020.
use strict;
use warnings;

use Module::Build 0.28;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.28"
  },
  "configure_requires" => {
    "Module::Build" => "0.28"
  },
  "dist_abstract" => "turn on Unicode - all of it",
  "dist_author" => [
    "Michael Schwern <mschwern\@cpan.org>",
    "Mike Doherty <doherty\@cpan.org>"
  ],
  "dist_name" => "utf8-all",
  "dist_version" => "0.015",
  "license" => "perl",
  "module_name" => "utf8::all",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Cwd" => 0,
    "Encode" => 0,
    "File::Find" => 0,
    "Import::Into" => 0,
    "Symbol" => 0,
    "charnames" => 0,
    "feature" => 0,
    "open" => 0,
    "parent" => 0,
    "perl" => "5.010",
    "strict" => 0,
    "utf8" => 0,
    "warnings" => 0
  },
  "script_files" => [],
  "test_requires" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "PerlIO" => 0,
    "Test::Fatal" => 0,
    "Test::More" => "0.96",
    "Test::Warn" => 0,
    "autodie" => 0,
    "constant" => 0,
    "version" => "0.77"
  }
);


my %fallback_build_requires = (
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Module::Build" => "0.28",
  "PerlIO" => 0,
  "Test::Fatal" => 0,
  "Test::More" => "0.96",
  "Test::Warn" => 0,
  "autodie" => 0,
  "constant" => 0,
  "version" => "0.77"
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
