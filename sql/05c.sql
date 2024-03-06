/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMP,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
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
        UNION ALL
        SELECT actor_id
        FROM film JOIN film_actor USING (film_id)
        WHERE title = f1.title
        INTERSECT ALL
        SELECT actor_id
        FROM film JOIN film_actor USING (film_id)
        WHERE title = 'AGENT TRUMAN'
        UNION ALL
        SELECT actor_id
        FROM film JOIN film_actor USING (film_id)
        WHERE title = f1.title
        INTERSECT ALL
        SELECT actor_id
        FROM film JOIN film_actor USING (film_id)
        WHERE title = 'AMERICAN CIRCUS'
    ) AS common_actors
) >= 3
ORDER BY title;
