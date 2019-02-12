use utf8;
package MyApp::Schema::Result::Test;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

__PACKAGE__->table("tests");

__PACKAGE__->add_columns(
    "id" => {
        data_type => "integer", extra => { unsigned => 1, auto_increment => 1 }
    },
    "name" => {
        data_type => "char", size => 32,
    },
    "data" => {
        data_type => "mediumtext",
    },
);

__PACKAGE__->set_primary_key("id");

__PACKAGE__->meta->make_immutable;

1;
