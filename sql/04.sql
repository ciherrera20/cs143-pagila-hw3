/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
SELECT first_name, last_name 
FROM film
    JOIN film_actor USING (film_id)
    JOIN actor USING (actor_id)
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
GROUP BY first_name, last_name
HAVING
    'Children' = ANY(ARRAY_AGG(DISTINCT name)) AND
    NOT ('Horror' = ANY(ARRAY_AGG(DISTINCT name)))
ORDER BY last_name, first_name;
