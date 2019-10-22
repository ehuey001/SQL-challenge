USE sakila;

SELECT * FROM actor COLUMNS;

/* ALTER TABLE actor
ADD COLUMN Actor_Names
INSERT INTO actor(Actor_Names) 
VALUES CONCAT(UPPER(first_name), ' ',  UPPER(last_name)); */

SELECT CONCAT(first_name, ' ', last_name) as Actor_Names FROM actor;

SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';

Select last_name FROM actor WHERE last_name LIKE '%GEN%';

Select last_name, first_name FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name;

Select country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD COLUMN description BLOB;

ALTER TABLE actor
DROP COLUMN description;

SELECT last_name, COUNT(last_name) 
FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(last_name) as c
FROM actor
GROUP BY last_name
HAVING c > 1;

UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

CREATE TABLE address (
	address_id SMALLINT(5),
    address VARCHAR(50),
    address2 VARCHAR(50),
    district VARCHAR(20),
    city_id SMALLINT(5),
    postal_code VARCHAR(10),
    phone VARCHAR(20),
    location GEOMETRY,
    last_update TIMESTAMP
);


SELECT staff.first_name, staff.last_name, address.address
FROM  staff
INNER JOIN address ON address.address_id;

SELECT * FROM payment;

SELECT SUM(payment.amount), staff.first_name
FROM payment
INNER JOIN staff ON staff.staff_id
GROUP BY staff.first_name;

select *
FROM film
WHERE title = "Hunchback Impossible";

SELECT 
    
	