-- First Round (imported from csv)
SELECT *
FROM first_round
ORDER BY Voivodeship, County;

-- Second Round (imported from csv)
SELECT *
FROM second_round
ORDER BY county;

-- Poland Salary (imported from csv)
SELECT *
FROM poland_salary
ORDER BY name;

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

SELECT * 
FROM big_cities_poland
ORDER BY city_name;

-- VIEW Votes by voivodeship
SELECT *
FROM votes_by_voivodeship;

-- VIEW Votes by county
SELECT *
FROM votes_by_county;

-- VIEW Average salaries by voivodeship
SELECT *
FROM avg_salaries_voivodeship;

-- VIEW Average salaries by county
SELECT *
FROM avg_salaries_county;

SELECT 	vc.county,
		avgsc.avg_salary,
        vc.dudavotes,
        vc.trzaskowskivotes
FROM votes_by_county as vc
RIGHT JOIN avg_salaries_county as avgsc ON vc.county = avgsc.name
ORDER BY avg_salary DESC;