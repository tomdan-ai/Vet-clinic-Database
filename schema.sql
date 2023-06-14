/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  date_of_birth DATE,
  escape_attempts INTEGER default 0,
  neutered BOOLEAN,
  weight_kg DECIMAL,
  species VARCHAR(100)
);

