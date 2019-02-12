-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Tue Feb 12 11:59:01 2019
-- 

;
BEGIN TRANSACTION;
--
-- Table: tests
--
CREATE TABLE tests (
  id INTEGER PRIMARY KEY NOT NULL,
  name char(32) NOT NULL,
  data mediumtext NOT NULL
);
COMMIT;
