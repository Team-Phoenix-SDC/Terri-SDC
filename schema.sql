
-- YOUR CODE GOES HERE
-- CREATE YOUR DATABASE
-- CREATE YOUR TABLES
-- ADD RECORDS TO YOUR TABLE

DROP DATABASE IF EXISTS SDCDatabase;

CREATE DATABASE SDCDatabase;

USE SDCDatabase;

-- "Camo Onesie","Blend in to your crowd","The So Fatigues will wake you up and fit you in. This high energy camo will have you blending in to even the wildest surroundings.","Jackets",140

DROP TABLE IF EXISTS product;

CREATE TABLE product (
  productID INT PRIMARY KEY,
  productName VARCHAR(120),
  productSlogan VARCHAR(140),
  productDescription VARCHAR(1000),
  productCategory VARCHAR(60),
  productPrice INT
);

copy product(productID, productName, productSlogan, productDescription, productCategory, productPrice)
FROM '/Users/teresagobble/Desktop/Terri-SDC/product.csv'
DELIMITER ','
CSV HEADER;

-- id,productId,name,sale_price,original_price,default_style
-- 1,1,"Forest Green & Black",null,140,1

DROP TABLE IF EXISTS style;

CREATE TABLE style (
  styleID INT PRIMARY KEY,
  productID INT,
  styleName VARCHAR(120),
  stylePrice INT,
  productPrice INT,
  defaultStyle INT,
  styleProductID INTEGER REFERENCES product (productID)
);

copy style(styleID, productID, styleName, stylePrice, productPrice, defaultStyle)
FROM '/Users/teresagobble/Desktop/Terri-SDC/styles.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

-- id,styleId,url,thumbnail_url
-- 1,1,"https://images.unsplash.com/photo-1501088430049-71c79fa3283e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80","https://images.unsplash.com/photo-1501088430049-71c79fa3283e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80"

DROP TABLE IF EXISTS photo;

CREATE TABLE photo (
  photoID INT,
  styleID INT,
  photoURL VARCHAR(300),
  thumbnailURL VARCHAR(300)
);
  -- photoProductID INTEGER REFERENCES style (styleID)

copy photo(photoID, styleID, photoURL, thumbnailURL)
FROM '/Users/teresagobble/Desktop/Terri-SDC/photos.csv'
delimiter ','
quote E'\b'
CSV HEADER;