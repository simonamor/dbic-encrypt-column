# dbic-encrypt-column
Example code for transparently encrypting/decrypting a database column using DBIx::Class

## Required Modules

Install all the required modules using the cpanfile.

 cpanm --installdeps .

Hopefully I've not missed any!

## Database Schema

Generate the database schema for use with this test. This is only required
if you have changed it from the structure in the repository since the ddl/
directory has been committed and this contains a working set of schema files.

Increment the $VERSION number in MyApp/Schema.pm and run the following:

 perl dh.pl write_ddl

This will generate an up-to-date set of schema files for SQLite including
upgrades from the previous version and those for deploying a fresh database.

## Run the test

 perl test_data.pl

## Check the database

Open the test database using the sqlite3 command line client.

 sqlite3 test.db

Select from the 'tests' table to see what is stored in there.

 sqlite> select * from tests;
 1|Mr Test|Encrypt this!
 sqlite>

If it's working correctly, the name column will be plain text but the
data column will be encrypted (unlike the above example).

