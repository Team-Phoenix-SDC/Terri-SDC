-- teresas-mbp:Terri-SDC teresagobble$ postgres
-- postgres does not know where to find the server configuration file.
-- You must specify the --config-file or -D invocation option or set the PGDATA environment variable.
-- teresas-mbp:Terri-SDC teresagobble$ psql -U teresagobble postgres

-- YOUR CODE GOES HERE
-- CREATE YOUR DATABASE
-- CREATE YOUR TABLES
-- ADD RECORDS TO YOUR TABLE

DROP DATABASE IF EXISTS SDCDatabase;

CREATE DATABASE SDCDatabase;

USE SDCDatabase;


-- CREATE INDEX friends_city_desc ON friends(city DESC);

-- "Camo Onesie","Blend in to your crowd","The So Fatigues will wake you up and fit you in. This high energy camo will have you blending in to even the wildest surroundings.","Jackets",140

DROP TABLE IF EXISTS product;

CREATE TABLE product (
  id INT,
  "name" VARCHAR(120),
  slogan VARCHAR(140),
  "description" VARCHAR(1000),
  category VARCHAR(60),
  default_price INT,
);

-- use of primary/reference keys
  -- id INT PRIMARY KEY,

copy product(id, name, slogan, description, category, default_price)
FROM '/Users/teresagobble/Desktop/Terri-SDC/product.csv'
DELIMITER ','
CSV HEADER;

-- id,productId,name,sale_price,original_price,default_style
-- 1,1,"Forest Green & Black",null,140,1

DROP TABLE IF EXISTS style;

CREATE TABLE style (
  id INT,
  productID INT,
  "name" VARCHAR(120),
  sale_price INT,
  original_price INT,
  default_style INT,
  styleProductID INTEGER REFERENCES product (id)
);
-- use of primary/reference keys
    -- id INT PRIMARY KEY,
    --

DROP INDEX styles_index;
CREATE INDEX styles_index ON style (productID);

copy style(id, productID, name, sale_price, original_price, default_style)
FROM '/Users/teresagobble/Desktop/Terri-SDC/styles.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

-- id,styleId,url,thumbnail_url
-- 1,1,"https://images.unsplash.com/photo-1501088430049-71c79fa3283e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80","https://images.unsplash.com/photo-1501088430049-71c79fa3283e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80"

DROP TABLE IF EXISTS photo;

CREATE TABLE photo (
  id INT,
  styleID INT,
  "url" VARCHAR(300),
  thumbnail_url VARCHAR(300)
);
  -- photoProductID INTEGER REFERENCES style (styleID)


CREATE INDEX photos_index ON photo (styleID);

copy photo(id, styleID, url, thumbnail_url)
FROM '/Users/teresagobble/Desktop/Terri-SDC/photos.csv'
quote E'\b'
delimiter ','
CSV HEADER;



-- add indexing to reduce query response times

DROP TABLE IF EXISTS feature;

CREATE TABLE feature (
  featureID INT,
  productID INT,
  featureType VARCHAR(50),
  featureValue1 VARCHAR(50),
  featureValue2 VARCHAR(50)
);
  -- photoProductID INTEGER REFERENCES style (styleID)

copy feature(featureID, productID, featureType, featureValue1, featureValue2)
FROM '/Users/teresagobble/Desktop/Terri-SDC/features.csv'
delimiter ','
NULL AS 'null'
quote E'\b'
CSV HEADER;



DROP TABLE IF EXISTS temporaryData;
  CREATE TABLE temporaryData (
    lumpedField TEXT
  );

COPY temporaryData FROM '/Users/teresagobble/Desktop/Terri-SDC/features.csv' WITH
NULL AS 'null'
-- quote E'\b'
CSV HEADER delimiter '#';

DROP TABLE IF EXISTS feature;

SELECT
split_part(lumpedField, ',', 1 ) AS featureID,
split_part(lumpedField, ',', 2 ) AS productID,
split_part(lumpedField, ',', 3 ) AS featureType,
split_part(lumpedField, ',', 4 ) AS featureValues1,
split_part(lumpedField, ',', 5 ) AS featureValues2
INTO feature
FROM temporaryData
;


-- CREATE TABLE feature (
--   featureID INT,
--   productID INT,
--   featureType VARCHAR(50),
--   featureValue1 VARCHAR(50),
--   featureValue2 VARCHAR(50)
-- );
--   -- photoProductID INTEGER REFERENCES style (styleID)

-- copy feature(featureID, productID, featureType, featureValue1, featureValue2)
-- FROM '/Users/teresagobble/Desktop/Terri-SDC/features.csv'
-- delimiter ','
-- NULL AS 'null'
-- quote E'\b'
-- CSV HEADER;






-- CREATE TABLE feature (
--   featureID INT,
--   productID INT,
--   featureType VARCHAR(50),
--   featureValue1 VARCHAR(50),
--   featureValue2 VARCHAR(50)
-- );
--   -- photoProductID INTEGER REFERENCES style (styleID)

-- copy feature(featureID, productID, featureType, featureValue1, featureValue2)
-- FROM '/Users/teresagobble/Desktop/Terri-SDC/features.csv'
-- delimiter ','
-- NULL AS 'null'
-- quote E'\b'
-- CSV HEADER;

