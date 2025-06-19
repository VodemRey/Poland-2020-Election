-- Big Cities Poland
DROP TABLE IF EXISTS big_cities_poland;
CREATE TABLE big_cities_poland (
    city_name VARCHAR(30)
);
INSERT INTO big_cities_poland (city_name) VALUES
('Warszawa'),
('Krakow'),
('Wroclaw'),
('Lodz'),
('Poznan'),
('Gdansk'),
('Szczecin'),
('Lublin'),
('Bydgoszcz'),
('Bialystok');


SELECT  * 
FROM avg_salaries_county as ascc 
RIGHT JOIN votes_by_county as vbc 
ON ascc.code = vbc.zip_code
ORDER BY name;  