-- Query 1: Top 5 films by average review score
SELECT
    f.id AS film_id,
    f.title,
    ROUND(AVG(r.imdb_score), 2) AS average_review_score
FROM films f
JOIN reviews r
    ON f.id = r.film_id
GROUP BY f.id, f.title
ORDER BY average_review_score DESC
LIMIT 5;




-- Query 2: Films with more than 5 reviews
SELECT
    f.id AS film_id,
    f.title,
    COUNT(r.id) AS number_of_reviews
FROM films f
JOIN reviews r
    ON f.id = r.film_id
GROUP BY f.id, f.title
HAVING COUNT(r.id) > 5
ORDER BY number_of_reviews DESC;





-- Query 3: Number of films each actor has appeared in

SELECT
    p.id AS people_id,
    p.name,
    COUNT(DISTINCT r.film_id) AS number_of_films
FROM people p
JOIN roles r
    ON p.id = r.people_id
WHERE LOWER(r.role) = 'actor'
GROUP BY p.id, p.name
ORDER BY number_of_films DESC;

