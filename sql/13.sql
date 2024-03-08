/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */
SELECT *
FROM (
    SELECT
        actor_id,
        first_name,
        last_name,
        film_id,
        title,
        RANK () OVER (
            PARTITION BY actor_id
            ORDER BY revenue DESC, title
        ) AS rank,
        revenue
    FROM actor
    JOIN film_actor USING (actor_id)
    JOIN film USING (film_id)
    JOIN (
        SELECT film_id, sum(amount) AS revenue
        FROM film
        JOIN inventory USING (film_id)
        JOIN rental USING (inventory_id)
        JOIN payment USING (rental_id)
        GROUP BY film_id
    ) AS revenue USING (film_id)
) AS ranked
WHERE rank <= 3
ORDER BY actor_id;
