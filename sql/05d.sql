/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */
SELECT DISTINCT title
FROM film f1
JOIN film_actor USING (film_id)
WHERE (
    SELECT count(*)
    FROM (
        SELECT actor_id
        FROM film JOIN film_actor USING (film_id)
        WHERE title = f1.title
        INTERSECT ALL
        SELECT actor_id
        FROM film JOIN film_actor USING (film_id)
        WHERE title = 'ACADEMY DINOSAUR'
    ) AS common_actors
) >= 1 AND (
    SELECT count(*)
    FROM (
        SELECT actor_id
        FROM film JOIN film_actor USING (film_id)
        WHERE title = f1.title
        INTERSECT ALL
        SELECT actor_id
        FROM film JOIN film_actor USING (film_id)
        WHERE title = 'AGENT TRUMAN'
    ) AS common_actors
) >= 1 AND (
    SELECT count(*)
    FROM (
        SELECT actor_id
        FROM film JOIN film_actor USING (film_id)
        WHERE title = f1.title
        INTERSECT ALL
        SELECT actor_id
        FROM film JOIN film_actor USING (film_id)
        WHERE title = 'AMERICAN CIRCUS'     
    ) AS common_actors
) >= 1
ORDER BY title;
