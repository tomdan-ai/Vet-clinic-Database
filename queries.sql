/*Queries that provide answers to the questions from all projects.*/

--Find all animals whose name ends in "mon":

SELECT * FROM animals WHERE name LIKE '%mon';

--List the names of all animals born between 2016 and 2019:

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

--List the names of all neutered animals with less than 3 escape attempts:

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

--List the date of birth of all animals named either "Agumon" or "Pikachu":

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

--List the name and escape attempts of animals that weigh more than 10.5kg:

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
-- Find all animals that are neutered:

SELECT * FROM animals WHERE neutered = true;

--Find all animals not named "Gabumon":

SELECT * FROM animals WHERE name != 'Gabumon';

--Find all animals with a weight between 10.4kg and 17.3kg (inclusive):

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Begin the transaction
BEGIN;

-- Update the species column to "unspecified"
UPDATE animals SET species = 'unspecified';

-- Verify the change
SELECT * FROM animals;

-- Rollback the transaction
ROLLBACK;

-- Verify the species column reverted to its previous state
SELECT * FROM animals;

-- Begin the transaction
BEGIN;

-- Update the species column to "digimon" for animals with name ending in "mon"
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Commit the transaction
COMMIT;

-- Verify the changes
SELECT * FROM animals;

-- Begin the transaction
BEGIN;

-- Update the species column to "pokemon" for animals without a species
UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species = '';

-- Commit the transaction
COMMIT;

-- Verify the changes
SELECT * FROM animals;

-- Begin the transaction
BEGIN;

-- Delete all records from the animals table
DELETE FROM animals;

-- Roll back the transaction
ROLLBACK;

-- Verify if all records still exist
SELECT * FROM animals;

-- Begin the transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT my_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO my_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

-- How many animals are there?
SELECT COUNT(*) AS total_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS animals_no_escape FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;