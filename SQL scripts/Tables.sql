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

ALTER TABLE big_cities_poland
ADD COLUMN latitude DECIMAL(8, 4),
ADD COLUMN longitude DECIMAL(8, 4);

UPDATE big_cities_poland SET latitude = 52.2297, longitude = 21.0122 WHERE city_name = 'Warszawa';
UPDATE big_cities_poland SET latitude = 50.0647, longitude = 19.9450 WHERE city_name = 'Krakow';
UPDATE big_cities_poland SET latitude = 51.1079, longitude = 17.0385 WHERE city_name = 'Wroclaw';
UPDATE big_cities_poland SET latitude = 51.7592, longitude = 19.4560 WHERE city_name = 'Lodz';
UPDATE big_cities_poland SET latitude = 52.4064, longitude = 16.9252 WHERE city_name = 'Poznan';
UPDATE big_cities_poland SET latitude = 54.3520, longitude = 18.6466 WHERE city_name = 'Gdansk';
UPDATE big_cities_poland SET latitude = 53.4285, longitude = 14.5528 WHERE city_name = 'Szczecin';
UPDATE big_cities_poland SET latitude = 51.2465, longitude = 22.5684 WHERE city_name = 'Lublin';
UPDATE big_cities_poland SET latitude = 53.1235, longitude = 18.0084 WHERE city_name = 'Bydgoszcz';
UPDATE big_cities_poland SET latitude = 53.1325, longitude = 23.1688 WHERE city_name = 'Bialystok';



