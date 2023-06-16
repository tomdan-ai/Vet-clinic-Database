/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  date_of_birth DATE,
  escape_attempts INTEGER default 0,
  neutered BOOLEAN,
  weight_kg DECIMAL,
);

-- Add the species column to the animals table
ALTER TABLE animals ADD species VARCHAR(100);

-- Create owners table in Vet_Clinic Database
CREATE TABLE owners (
  id PRIMARY KEY SERIAL,
  full_name VARCHAR(100),
  age INT
);

-- Create species Table in vet_clinic Datebase
CREATE TABLE species (
  id PRIMARY KEY SERIAL,
  name VARCHAR(100)
);

-- Remove the column species
ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id as a foreign key referencing the species table
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id);

-- Add column owner_id as a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id);

-- Creare vets Table in vet_clinic Database

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

-- Create a join table called specializations to handle the many-to-many relationship between the species and vets tables

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets (id),
    FOREIGN KEY (species_id) REFERENCES species (id)
);

-- Create a join table called "visits" to handle the many-to-many relationship between the "animals" and "vets" tables, including tracking the date of the visit

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    PRIMARY KEY (animal_id, vet_id, visit_date),
    FOREIGN KEY (animal_id) REFERENCES animals (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id)
);
