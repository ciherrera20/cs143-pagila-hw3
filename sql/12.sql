/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
SELECT customer_id, first_name, last_name
FROM customer
JOIN LATERAL (
    SELECT count(film_id) AS num
    FROM (
        SELECT film_id
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
WHERE num >= 4
ORDER BY customer_id;
