/*
 * Find every documentary film that is rated G.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */
SELECT film.title, actors
FROM film
JOIN film_category USING (film_id)
JOIN category USING (category_id)
JOIN nicer_but_slower_film_list ON (fid = film_id AND category = name)
WHERE film.rating = 'G' AND name = 'Documentary'
ORDER BY film.title;

SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    group_concat(((upper("substring"(actor.first_name, 1, 1)) || lower("substring"(actor.first_name, 2))) || upper("substring"(actor.last_name, 1, 1))) || lower("substring"(actor.last_name, 2))) AS actors
   FROM category
     LEFT JOIN film_category ON category.category_id = film_category.category_id
     LEFT JOIN film ON film_category.film_id = film.film_id
     JOIN film_actor ON film.film_id = film_actor.film_id
     JOIN actor ON film_actor.actor_id = actor.actor_id
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;

SELECT
    title,
    film_id,
    group_concat(((upper("substring"(actor.first_name, 1, 1)) || lower("substring"(actor.first_name, 2))) || upper("substring"(actor.last_name, 1, 1))) || lower("substring"(actor.last_name, 2))) AS actors
FROM film
    JOIN film_actor USING (film_id)
    JOIN actor USING (actor_id)
GROUP BY title, film_id;

SELECT
    title,
    film_id,
    first_name,
    last_name,
    actor_id
FROM film
    JOIN film_actor USING (film_id)
    JOIN actor USING (actor_id)
ORDER BY title, actor_id;
