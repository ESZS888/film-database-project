CREATE TABLE films (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER,
    place_name VARCHAR(100),
    duration INTEGER,
    language VARCHAR(100),
    certification VARCHAR(50),
    gross BIGINT,
    budget BIGINT,
    CONSTRAINT chk_release_year CHECK (release_year IS NULL OR release_year BETWEEN 1880 AND 2030),
    CONSTRAINT chk_duration CHECK (duration IS NULL OR duration > 0),
    CONSTRAINT chk_gross CHECK (gross IS NULL OR gross >= 0),
    CONSTRAINT chk_budget CHECK (budget IS NULL OR budget >= 0)
);

CREATE TABLE people (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birthdate DATE,
    deathdate DATE,
    CONSTRAINT chk_life_dates CHECK (deathdate IS NULL OR birthdate IS NULL OR deathdate >= birthdate)
);

CREATE TABLE reviews (
    id INTEGER PRIMARY KEY,
    film_id INTEGER NOT NULL,
    num_critic INTEGER,
    imdb_score NUMERIC(3,1),
    num_votes INTEGER,
    facebook_likes INTEGER,
    CONSTRAINT fk_reviews_film
        FOREIGN KEY (film_id) REFERENCES films(id),
    CONSTRAINT chk_imdb_score CHECK (imdb_score IS NULL OR imdb_score BETWEEN 0 AND 10),
    CONSTRAINT chk_num_critic CHECK (num_critic IS NULL OR num_critic >= 0),
    CONSTRAINT chk_num_votes CHECK (num_votes IS NULL OR num_votes >= 0),
    CONSTRAINT chk_facebook_likes CHECK (facebook_likes IS NULL OR facebook_likes >= 0)
);

CREATE TABLE roles (
    id INTEGER PRIMARY KEY,
    film_id INTEGER NOT NULL,
    people_id INTEGER NOT NULL,
    role VARCHAR(100),
    CONSTRAINT fk_roles_film
        FOREIGN KEY (film_id) REFERENCES films(id),
    CONSTRAINT fk_roles_people
        FOREIGN KEY (people_id) REFERENCES people(id)
);