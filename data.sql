/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
  ('Agumon', '2020-02-03', 0, true, 10.23, NULL),
  ('Gabumon', '2018-11-15', 2, true, 8, NULL),
  ('Pikachu', '2021-01-07', 1, false, 15.04, NULL),
  ('Devimon', '2017-05-12', 5, true, 11, NULL),
  ('Charmander', '2020-02-08', 0, false, -11, NULL),
  ('Plantmon', '2021-11-15', 2, true, -5.7, NULL),
  ('Squirtle', '1993-04-02', 3, false, -12.13, NULL),
  ('Angemon', '2005-06-12', 1, true, -45, NULL),
  ('Boarmon', '2005-06-07', 7, true, 20.4, NULL),
  ('Blossom', '1998-10-13', 3, true, 17, NULL),
  ('Ditto', '2022-05-14', 4, true, 22, NULL);

-- Insert data into the owners table
INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- Insert data into the species table
INSERT INTO species (name)
VALUES
    ('Pokemon'),
    ('Digimon');


-- Update animals table to include species_id values
UPDATE animals
SET species_id = (
    CASE
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END
);


-- Update animals table to include owner_id values
UPDATE animals
SET owner_id = (
    CASE
        WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
        WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
        WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
        WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
        WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
    END
);

-- Insert the provided data for the vets into the vets table

INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('William Tatcher', 45, '2000-04-23');

INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Maisy Smith', 26, '2019-01-17');

INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Stephanie Mendez', 64, '1981-05-04');

INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Jack Harkness', 38, '2008-06-08');

-- Insert the provided data for specialties into the "specializations" join table

-- Get the vet_id for William Tatcher
INSERT INTO specializations (vet_id, species_id) 
VALUES (
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    (SELECT id FROM species WHERE name = 'Pokemon')
);

-- Get the vet_id for Stephanie Mendez
INSERT INTO specializations (vet_id, species_id) 
VALUES (
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    (SELECT id FROM species WHERE name = 'Digimon')
);

INSERT INTO specializations (vet_id, species_id) 
VALUES (
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    (SELECT id FROM species WHERE name = 'Pokemon')
);

-- Get the vet_id for Jack Harkness
INSERT INTO specializations (vet_id, species_id) 
VALUES (
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    (SELECT id FROM species WHERE name = 'Digimon')
);


-- Insert the provided data for visits into the "visits" join table

-- Get the animal_id and vet_id for each visit

-- Agumon visited William Tatcher
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES (
    (SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2020-05-24'
);

-- Agumon visited Stephanie Mendez
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES (
    (SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2020-07-22'
);

-- Gabumon visited Jack Harkness
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES (
    (SELECT id FROM animals WHERE name = 'Gabumon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2021-02-02'
);

-- Pikachu visited Maisy Smith on multiple dates
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES 
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14');

-- Devimon visited Stephanie Mendez
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES (
    (SELECT id FROM animals WHERE name = 'Devimon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2021-05-04'
);

-- Charmander visited Jack Harkness
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES (
    (SELECT id FROM animals WHERE name = 'Charmander'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2021-02-24'
);

-- Plantmon visited Maisy Smith and William Tatcher on multiple dates
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES 
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07');

-- Squirtle visited Stephanie Mendez
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES (
    (SELECT id FROM animals WHERE name = 'Squirtle'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2019-09-29'
);

-- Angemon visited Jack Harkness on multiple dates
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES 
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04');

-- Boarmon visited Maisy Smith on multiple dates
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES 
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03');

-- Blossom visited Stephanie Mendez and William Tatcher
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES 
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');

