/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */
SELECT DISTINCT title
FROM film
JOIN film_actor USING (film_id)
WHERE (
    SELECT count(*)
    FROM (
        SELECT actor_id
        FROM film_actor
        WHERE film_id = film.film_id
        INTERSECT
        SELECT actor_id
        FROM film_actor
        WHERE film_id = 21
    ) AS common_actors
) >= 2
ORDER BY title;
