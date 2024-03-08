/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
SELECT name, title, "total rentals"
FROM (
    SELECT
        name,
        title,
        "total rentals",
        RANK () OVER (
            PARTITION BY name
            ORDER BY "total rentals" DESC, title DESC
        ) AS rank
    FROM film
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
    JOIN (
        SELECT film_id, count(*) AS "total rentals"
        FROM rental
        JOIN inventory USING (inventory_id)
        GROUP BY film_id
    ) AS total_rentals USING (film_id)
) AS ranked
WHERE rank <= 5
ORDER BY name, "total rentals" DESC, title;
