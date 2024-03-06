/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
SELECT DISTINCT title
FROM film
JOIN film_category USING (film_id)
WHERE (
    SELECT count(*)
    FROM (
        SELECT category_id
        FROM film_category
        WHERE film_id = film.film_id
        INTERSECT
        SELECT category_id
        FROM film_category
        WHERE film_id = 21
    ) AS common_categories
) >= 2 AND
(
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
) >= 1
ORDER BY title;
