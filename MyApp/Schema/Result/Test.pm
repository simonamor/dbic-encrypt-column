use utf8;
package MyApp::Schema::Result::Test;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

use Crypt::CBC;

__PACKAGE__->load_components(qw/FilterColumn/);

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

__PACKAGE__->filter_column(
    "data" => {
        filter_to_storage => 'encrypt_data',
        filter_from_storage => 'decrypt_data',
    }
);

__PACKAGE__->set_primary_key("id");

# Hardcoded cipher key here - ideally it would be in the app config.
# Ensure the key is the right length, between 16 and 32 characters!
my $cipher = Crypt::CBC->new(
    -cipher => 'Crypt::Cipher::AES',
    -key => 'Puqqcjtmtfvtlplhvelbksdemejyf@po',
);

# These methods convert between plaintext
# and base64 encoded AES encrypted data.

# If you never wanted to select data from the database using a normal
# client, you could easily skip the base64 encoding and simply store
# binary data directly in the column. If this was the case, you'd
# change the definition from char to blob (assuming blob is valid for
# your database).
sub encrypt_data {
    return $_[1] ? $cipher->encrypt_hex($_[1]) : undef;
}

sub decrypt_data {
    return $_[1] ? $cipher->decrypt_hex($_[1]) : undef;
}

__PACKAGE__->meta->make_immutable;

1;
