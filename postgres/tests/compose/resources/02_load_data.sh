#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" datadog_test <<-EOSQL
    -- NOTE: ensure all tables have at least one sufficiently large row, so that Postgres'
    -- TOAST mechanism kicks in for that table and the associated metrics are submitted.

    CREATE TABLE persons (personid SERIAL, lastname VARCHAR(255), firstname VARCHAR(255), address VARCHAR(255), city VARCHAR(255));
    INSERT INTO persons (lastname, firstname, address, city) VALUES ('Cavaille', 'Leo', 'Midtown', 'New York'), ('Someveryveryveryveryveryveryveryveryveryverylongname', 'something', 'Avenue des Champs Elysees', 'Beautiful city of lights');
    SELECT * FROM persons;

    CREATE TABLE personsdup1 (personid SERIAL, lastname VARCHAR(255), firstname VARCHAR(255), address VARCHAR(255), city VARCHAR(255));
    INSERT INTO personsdup1 (lastname, firstname, address, city) VALUES ('Cavaille', 'Leo', 'Midtown', 'New York'), ('Someveryveryveryveryveryveryveryveryveryverylongname', 'something', 'Avenue des Champs Elysees', 'Beautiful city of lights');
    SELECT * FROM personsdup1;

    CREATE TABLE Personsdup2 (personid SERIAL, lastname VARCHAR(255), firstname VARCHAR(255), address VARCHAR(255), city VARCHAR(255));
    INSERT INTO Personsdup2 (lastname, firstname, address, city) VALUES ('Cavaille', 'Leo', 'Midtown', 'New York'), ('Someveryveryveryveryveryveryveryveryveryverylongname', 'something', 'Avenue des Champs Elysees', 'Beautiful city of lights');
    SELECT * FROM Personsdup2;

    CREATE SCHEMA IF NOT EXISTS doghouse;
    CREATE TABLE doghouse.dog (id SERIAL, name VARCHAR(255), description TEXT);
    INSERT INTO doghouse.dog (name, description) VALUES ('Bits', 'Proident quis magna reprehenderit elit. Eiusmod elit consectetur adipisicing cupidatat non do ad voluptate ad. Aliqua sint ad deserunt dolor consectetur ex nostrud. Esse sunt est et magna labore aliquip sit ipsum eu do dolor voluptate voluptate eu. Irure ut laboris non laborum sint et sunt adipisicing eiusmod.');
    SELECT * FROM doghouse.dog;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" dogs <<-EOSQL
    CREATE TABLE breed (id SERIAL, name VARCHAR(255));
    CREATE TABLE kennel (id SERIAL, address VARCHAR(255));
    INSERT INTO kennel (address) VALUES ('Midtown, New York'), ('Boston');
    SELECT * FROM kennel;
    CREATE INDEX breed_names ON breed(name);
    INSERT INTO breed (name) VALUES ('Labrador Retriver'), ('German Shepherd'), ('Yorkshire Terrier'), ('Golden Retriever'), ('Bulldog');
    SELECT * FROM breed WHERE name = 'Labrador';
EOSQL
