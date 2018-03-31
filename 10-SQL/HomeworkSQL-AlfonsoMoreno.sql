USE sakila;

-- 1a. Display the first and last names of all actors from the table actor.
SELECT first_name, last_name
FROM actor;
-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
SELECT CONCAT(first_name, ' ', last_name) 
FROM actor;
-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'Joe%';
-- 2b. Find all actors whose last name contain the letters GEN:
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';
-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE '%li%';
-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country, country_id
  FROM country
  WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.
ALTER TABLE actor 
ADD COLUMN middle_name VARCHAR(45) AFTER first_name;
SELECT * FROM actor;	
-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.
ALTER TABLE actor
MODIFY COLUMN middle_name BLOB(100);
-- 3c. Now delete the middle_name column.
ALTER TABLE actor
DROP COLUMN middle_name;
SELECT * FROM actor;
-- 4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, actor_id
FROM actor
WHERE last_name IS NOT NULL;

SELECT COUNT(last_name)
FROM actor
WHERE last_name IS NOT NULL;
-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT last_name
FROM (
SELECT last_name, COUNT(*) AS count
FROM actor as a
GROUP BY last_name) b
WHERE count> 1;

-- 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.
SELECT first_name
FROM actor
WHERE last_name like 'WILLIAMS%';

UPDATE actor
SET first_name = 'HARPO'
WHERE first_name like 'GROUCHO%' AND last_name like 'WILLIAMS%';

-- 4d. In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. 
-- Otherwise, change the first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)

IF first_name IN (N'Saturday', N'Sunday')
		UPDATE actor
		SET first_name = 'HARPO';
ELSE 
       SELECT 'MUCHO';
       
       
-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] db_name
    [create_specification] ...

create_specification:
    [DEFAULT] CHARACTER SET [=] charset_name
  | [DEFAULT] COLLATE [=] collation_name

-- Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. 
-- Use the tables staff and address:
 
SELECT first_name, last_name, address.address
FROM staff
INNER JOIN address ON staff.address_id = address.address_id;  

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. 
-- Use tables staff and payment.

SELECT department_id "Department Code", 
COUNT(*) "No of Employees", 
SUM(salary) "Total Salary" 
FROM  employees 
GROUP BY  department_id; 

SELECT * FROM rental;


-- 6c. List each film and the number of actors who are listed for that film.
--  Use tables film_actor and film. Use inner join.

SELECT title "Name of Film", COUNT(*) "No of Actors"
from (
    SELECT title, actor_id
	FROM film
	INNER JOIN film_actor ON film.film_id = film_actor.film_id) a
GROUP BY actor_id;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT * FROM inventory;

SELECT COUNT(film_id) as "No of Copies"
FROM inventory
WHERE film_id LIKE (
    SELECT film_id
	FROM film
    WHERE title LIKE 'Hunchback Impossible');

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
-- 	![Total amount paid](Images/total_payment.png)



-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

SELECT *
FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%' ;


-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.

SELECT first_name, last_name
FROM actor
WHERE actor_id LIKE (
	SELECT actor_id
	FROM film_actor
	WHERE film_id LIKE (
		SELECT film_id
		FROM film
		WHERE title LIKE 'Alone Trip')
	);


-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
-- 7e. Display the most frequently rented movies in descending order.
-- 7f. Write a query to display how much business, in dollars, each store brought in.
-- 7g. Write a query to display for each store its store ID, city, and country.
-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
-- 8b. How would you display the view that you created in 8a?
-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.