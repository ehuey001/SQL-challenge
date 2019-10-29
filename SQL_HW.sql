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

select title, COUNT(inventory_id) as 'num copies'
FROM film
INNER JOIN inventory
using (film_id)
WHERE title = "Hunchback Impossible"
Group By title;

SELECT * FROM payment;

SELECT * FROM customer;

SELECT c.first_name, c.last_name, SUM(p.amount) as paid_total
FROM payment as p
INNER JOIN customer AS c
ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name;

SELECT title
FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%'
AND language_id IN
(
	SELECT language_id
    FROM language
    WHERE name = 'English'
    );

SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
	SELECT actor_id
    FROM film_actor
    WHERE film_id = 
    (
		SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
        )
	);

SELECT first_name, last_name, email, country
FROM customer as cust
INNER JOIN address as a
ON (cust.address_id = a.address_id)
INNER JOIN city 
ON (a.city_id = city.city_id)
INNER JOIN country as ctry
ON (city.country_id = ctry.country_id)
WHERE ctry.country = 'canada';

SELECT title, cat.name
FROM film
INNER JOIN film_category as fc
ON (film.film_id = fc.film_id)
INNER JOIN category cat
ON (cat.category_id = fc.category_id)
WHERE name = 'family';

SELECT title, COUNT(title) as 'Num Rentals'
FROM film as f
INNER JOIN inventory as i
ON (f.film_id = i.film_id)
INNER JOIN rental as r
ON (i.inventory_id = r.inventory_id)
GROUP BY title
ORDER BY 'Num Rentals' desc;

SELECT s.store_id, SUM(amount) AS 'gross revenue'
FROM payment p
INNER JOIN rental r
ON (p.rental_id = r.rental_id)
INNER JOIN inventory i
ON (i.inventory_id = r.inventory_id)
INNER JOIN store s
ON (s.store_id = i.store_id)
GROUP BY s.store_id;

SELECT store_id, city, country
FROM store s
INNER JOIN address a
ON (s.address_id = a.address_id)
INNER JOIN city
ON (city.city_id = a.city_id)
INNER JOIN country ctry
ON (city.country_id = ctry.country_id);

SELECT SUM(amount) as 'Total Sales', cat.name as 'Genre'
FROM payment p
INNER JOIN rental r
ON (p.rental_id = r.rental_id)
INNER JOIN inventory i
ON (r.inventory_id = i.inventory_id)
INNER JOIN film_category fc
on (i.film_id = fc.film_id)
INNER JOIN category cat
ON (fc.category_id = cat.category_id)
GROUP BY cat.name
ORDER BY SUM(amount) DESC
LIMIT 5;	

CREATE VIEW top_five_genres AS
SELECT SUM(amount) as 'Total Sales', cat.name as 'Genre'
FROM payment p
INNER JOIN rental r
ON (p.rental_id = r.rental_id)
INNER JOIN inventory i
ON (r.inventory_id = i.inventory_id)
INNER JOIN film_category fc
on (i.film_id = fc.film_id)
INNER JOIN category cat
ON (fc.category_id = cat.category_id)
GROUP BY cat.name
ORDER BY SUM(amount) DESC
LIMIT 5;	

SELECT * FROM top_five_genres;

DROP VIEW top_five_genres;