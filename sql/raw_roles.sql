CREATE TABLE raw_roles (
    id TEXT,
    film_id TEXT,
    people_id TEXT,
    role TEXT
);

SELECT DISTINCT TRIM(r.film_id) AS invalid_film_id
FROM raw_roles r
LEFT JOIN films f
ON TRIM(r.film_id) = f.id::TEXT
WHERE r.film_id IS NOT NULL
  AND TRIM(r.film_id) <> ''
  AND f.id IS NULL
ORDER BY invalid_film_id;


DELETE FROM raw_roles r
WHERE r.film_id IS NOT NULL
  AND TRIM(r.film_id) <> ''
  AND NOT EXISTS (
      SELECT 1
      FROM films f
      WHERE f.id::TEXT = TRIM(r.film_id)
  );