DROP TABLE IF EXISTS planets;

CREATE TABLE planets (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  planet_type VARCHAR(50) NOT NULL,
  diameter_km INT NOT NULL,
  mass_earths DECIMAL(10,4),
  distance_from_sun_m_km DECIMAL(10,3) NOT NULL,
  moons INT NOT NULL DEFAULT 0,
  has_rings BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO planets
  (name, planet_type, diameter_km, mass_earths, distance_from_sun_m_km, moons, has_rings)
VALUES
  ('Mercury', 'Terrestrial',   4879,   0.0553,   57.910,   0, FALSE),
  ('Venus',   'Terrestrial',  12104,   0.8150,  108.200,   0, FALSE),
  ('Earth',   'Terrestrial',  12742,   1.0000,  149.600,   1, FALSE),
  ('Mars',    'Terrestrial',   6779,   0.1074,  227.900,   2, FALSE),
  ('Jupiter', 'Gas Giant',   139820, 317.8000,  778.500,  95, TRUE),
  ('Saturn',  'Gas Giant',   116460,  95.2000, 1432.000, 146, TRUE),
  ('Uranus',  'Ice Giant',    50724,  14.5000, 2867.000,  28, TRUE),
  ('Neptune', 'Ice Giant',    49244,  17.1000, 4515.000,  16, TRUE);