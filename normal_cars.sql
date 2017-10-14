\c nniosco;
DROP DATABASE IF EXISTS normal_cars;
DROP USER IF EXISTS normal_user;

-- Create a new postgres user named normal_user.

CREATE USER normal_user;

-- Create a new database named normal_cars owned by normal_user.

CREATE DATABASE normal_cars WITH OWNER normal_user;
\c normal_cars;
-- \i scripts/denormal_data.sql;

-- Whiteboard your solution to normalizing the denormal_cars schema.

-- [bonus] Generate a diagram (somehow) in .png (or other) format, that of your normalized cars schema. (save and commit to this repo).

-- In normal_cars.sql Create a query to generate the tables needed to accomplish your normalized schema, including any primary and foreign key constraints. Logical renaming of columns is allowed.

CREATE TABLE IF NOT EXISTS makes (
  id          serial       PRIMARY KEY,
  make_code   varchar(255) NOT NULL,
  make_title  varchar(255) NOT NULL
);

-- SELECT *
--   FROM makes;
-- DROP TABLE IF EXISTS years;

CREATE TABLE IF NOT EXISTS years (
    year   int   PRIMARY KEY
);

-- SELECT *
--   FROM years;

-- DROP TABLE IF EXISTS models;

CREATE TABLE IF NOT EXISTS models (
  id           serial         primary key,
  model_code   varchar(255)   NOT NULL,
  model_title  varchar(255)   NOT NULL,
  make_ID      int            references makes(id),
  year_ID      int            references years(year)
);

-- INSERT INTO models (make_ID, year_ID)

-- SELECT * 
--   FROM models; 

-- Using the resources that you now possess, In normal_cars.sql Create queries to insert all of the data that was in the denormal_cars.car_models table, into the new normalized tables of the normal_cars database.

INSERT INTO makes (make_code, make_title)
SELECT DISTINCT make_code, make_title
  FROM denormal_cars.car_models;

INSERT INTO years (year)
SELECT DISTINCT year
  FROM denormal_cars.car_models;

INSERT INTO models (model_code, model_title)
SELECT DISTINCT model_code, model_title
  FROM denormal_cars.car_models;

-- In normal_cars.sql Create a query to get a list of all make_title values in the car_models table. Without any duplicate rows, this should have 71 results.

SELECT DISTINCT make_title
  FROM denormal_cars.car_models;

--   FROM models; 
-- In normal_cars.sql Create a query to list all model_title values where the make_code is 'VOLKS' Without any duplicate rows, this should have 27 results.

SELECT DISTINCT model_title
  FROM denormal_cars.car_models
  WHERE make_code = 'VOLKS';

-- In normal_cars.sql Create a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM'. Without any duplicate rows, this should have 136 rows.

SELECT DISTINCT *
  FROM denormal_cars.car_models
  WHERE make_code = 'LAM';

-- In normal_cars.sql Create a query to list all fields from all car_models in years between 2010 and 2015. Without any duplicate rows, this should have 7884 rows.

SELECT DISTINCT *
  FROM denormal_cars.car_models
  WHERE year BETWEEN 2010 and 2015;