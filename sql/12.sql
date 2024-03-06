/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
SELECT customer_id, first_name, last_name, num
FROM customer
JOIN LATERAL (
    SELECT count(film_id) AS num
    FROM (
        SELECT title, film_id, customer_id, rental_date
        FROM rental
        JOIN inventory USING (inventory_id)
        JOIN film USING (film_id)
        WHERE customer_id = customer.customer_id
        ORDER BY rental_date DESC
        LIMIT 5
    ) AS latest
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
    WHERE name = 'Action'
) AS count_action ON TRUE
ORDER BY customer_id;

SELECT first_name, last_name, title, rental_date
FROM customer
JOIN LATERAL (
    SELECT title, rental_date
    FROM rental
    JOIN inventory USING (inventory_id)
    JOIN film USING (film_id)
    WHERE customer_id = customer.customer_id
    ORDER BY rental_date DESC
    LIMIT 1
) r ON TRUE
ORDER BY last_name;

SELECT title, film_id, rental_date, name
FROM (
    SELECT max(title) AS title, film_id, max(rental_date) AS rental_date
    FROM rental
    JOIN inventory USING (inventory_id)
    JOIN film USING (film_id)
    WHERE customer_id = 1
    GROUP BY film_id
    ORDER BY rental_date DESC
    LIMIT 5
) AS latest
JOIN film_category USING (film_id)
JOIN category USING (category_id)
ORDER BY rental_date DESC;

SELECT customer_id, first_name, last_name, title, name
FROM customer
JOIN rental USING (customer_id)
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE customer_id = 1 AND name = 'Action';
