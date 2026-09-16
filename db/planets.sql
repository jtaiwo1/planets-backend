DROP TABLE IF EXISTS planets;

CREATE TABLE planets (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO planets (name) VALUES ('Example one'), ('Example two');
