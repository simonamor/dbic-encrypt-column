#!/usr/bin/env perl
#
# dh.pl

use App::DH;
{
    package MyApp::DH;
    use Moose;
    use Path::Class;
    extends 'App::DH';

    has '+connection_name' => (
        default => sub { 'dbi:SQLite:./test.db' }
    );
    has '+schema' => (
        default => sub { 'MyApp::Schema' }
    );
    has '+include' => (
        default => sub { [ dir( 'lib' )->stringify ] }
    );
    has '+script_dir' => (
        default => sub { dir( 'ddl' )->stringify }
    );

    __PACKAGE__->meta->make_immutable;
}

# Hack to make it generate SQL for all 3 database types
if (grep { /write_ddl/ } @ARGV) {
    unshift @ARGV, "-d", "SQLite";
}

MyApp::DH->new_with_options->run;

