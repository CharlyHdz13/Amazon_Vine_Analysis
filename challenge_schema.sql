CREATE TABLE review_id_table (
  review_id TEXT PRIMARY KEY NOT NULL,
  customer_id INTEGER,
  product_id TEXT,
  product_parent INTEGER,
  review_date DATE -- this should be in the formate yyyy-mm-dd
);

-- This table will contain only unique values
CREATE TABLE products_table (
  product_id TEXT PRIMARY KEY NOT NULL UNIQUE,
  product_title TEXT
);

-- Customer table for first data set
CREATE TABLE customers_table (
  customer_id INT PRIMARY KEY NOT NULL UNIQUE,
  customer_count INT
);

-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

-- Check that tables where exported succesfully
SELECT * FROM review_id_table;
SELECT * FROM products_table;
SELECT * FROM customers_table;
SELECT * FROM vine_table;

-- Create table from vine_table where the number of total_votes is equal or greater than 20
SELECT * 
INTO total_votes_table
FROM vine_table
WHERE total_votes >= 20;

SELECT * FROM total_votes_table;

-- Create table where the percentage of helpful votes is equal or greater than 50% from the total amount of votes
SELECT *
INTO total_helpful_votes_table
FROM total_votes_table
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT)>=0.5;

SELECT * FROM total_helpful_votes_table;

-- Create table with only paid
SELECT * 
INTO vine_y_table
FROM total_helpful_votes_table
WHERE vine = 'Y';

SELECT * FROM vine_y_table;

-- Create table with only unpaid
SELECT * 
INTO vine_n_table
FROM total_helpful_votes_table
WHERE vine = 'N';

SELECT * FROM vine_n_table;

-- Get total number of reviews
SELECT COUNT(review_id) AS total_number_reviews
FROM vine_table;

-- Get total number of 5 star reviews
SELECT COUNT(review_id) AS total_5star_reviews
FROM vine_table
WHERE star_rating = 5;

-- Get percentage of 5 star reviews for paid
SELECT (SELECT CAST(COUNT(review_id) AS FLOAT)
		FROM vine_table
		WHERE star_rating = 5 AND vine = 'Y')/
		(SELECT CAST(COUNT(review_id) AS FLOAT)
		FROM vine_table
		WHERE star_rating = 5)*100 AS percentage_paid_reviews;

-- Get percentage of 5 star reviews for unpaid
SELECT (SELECT CAST(COUNT(review_id) AS FLOAT)
		FROM vine_table
		WHERE star_rating = 5 AND vine = 'N')/
		(SELECT CAST(COUNT(review_id) AS FLOAT)
		FROM vine_table
		WHERE star_rating = 5)*100 AS percentage_unpaid_reviews;
