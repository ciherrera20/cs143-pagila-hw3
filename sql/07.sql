/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
SELECT first_name || ' ' || last_name AS "Actor Name"
FROM actor JOIN (
    SELECT DISTINCT a3.actor_id
    FROM actor a1
    JOIN film_actor fa1 ON fa1.actor_id = a1.actor_id
    JOIN film_actor fa2 ON fa2.film_id = fa1.film_id
    JOIN actor a2       ON a2.actor_id = fa2.actor_id
    JOIN film_actor fa3 ON fa3.actor_id = a2.actor_id
    JOIN film_actor fa4 ON fa4.film_id = fa3.film_id
    JOIN actor a3       ON a3.actor_id = fa4.actor_id
    WHERE a1.first_name = 'RUSSELL' AND a1.last_name = 'BACALL'
    EXCEPT
    SELECT DISTINCT a2.actor_id
    FROM actor a1
    JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
    JOIN film_actor fa2 ON fa2.film_id = fa1.film_id 
    JOIN actor a2       ON a2.actor_id = fa2.actor_id
    WHERE a1.first_name = 'RUSSELL' AND a1.last_name = 'BACALL'
) AS actor_ids USING (actor_id)
ORDER BY "Actor Name";
