DROP TABLE tickets;
DROP TABLE films;

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  director_name VARCHAR(255)
);


CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  customer_name VARCHAR(255),
  -- film_id int4,
  film_id int4 REFERENCES films(id) ON DELETE SET NULL
);
