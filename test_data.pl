#!/usr/bin/env perl

use utf8;

use lib ".";

use strict;
use warnings;

use Path::Class;
use MyApp::Schema;
use DBIx::Class::DeploymentHandler;

my $schema = MyApp::Schema->connect("dbi:SQLite:./test.db");

my $dh = DBIx::Class::DeploymentHandler->new({
    schema => $schema,
    force_overwrite => 1,
    script_directory => dir("ddl")->stringify,
    databases => [ $schema->storage->sqlt_type ],
});
if ($dh->version_storage_is_installed) {
    warn "Checking for schema upgrade";
    my $ret = eval {
        $dh->upgrade();
    };
    die "upgrade failed: $@\n" if $@;
} else {
    warn "Installing schema";
    my $ret = eval {
        $dh->install();
    };
    die "install failed: $@\n" if $@;
}

my $resultset = $schema->resultset("Test");
my $num = int(rand() * 50);
my $new_test = $resultset->create({
    name => "Mr Test",
    data => "Encrypt this! $num character padding:" . ("x" x $num),
});

print "== Writing record ", $new_test->id, "\n";
print "write name: ", $new_test->name, "\n";
print "write data: ", $new_test->data, "\n";

print "== Fetching record ", $new_test->id, "\n";
my $read_test = $resultset->find($new_test->id);
print " read name: ", $read_test->name, "\n";
print " read data: ", $read_test->data, "\n";

