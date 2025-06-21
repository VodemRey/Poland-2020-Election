-- VIEW Total votes
DROP VIEW IF EXISTS total_votes;
CREATE VIEW total_votes AS
SELECT  SUM(number_of_eligible_voters) as TotalEligibleVoters,
        SUM(number_of_votes) as TotalVotes,
        ROUND(SUM(andrzej_duda) / SUM(number_of_votes) * 100, 2) as DudaVotes,
        ROUND(SUM(rafal_trzaskowski) / SUM(number_of_votes) * 100, 2) as TrzaskowskiVotes
FROM second_round;

-- VIEW Votes by county
DROP VIEW IF EXISTS votes_by_county;
CREATE VIEW votes_by_county AS 
SELECT 	zip_code,
        county,
	ROUND(andrzej_duda / number_of_votes * 100, 2) as DudaVotes,
        ROUND(rafal_trzaskowski / number_of_votes * 100, 2) as TrzaskowskiVotes
FROM second_round
ORDER BY zip_code;

SELECT *
FROM votes_by_county;

-- VIEW Big cities votes percent (2 round)
DROP VIEW IF EXISTS votes_by_big_cities;
CREATE VIEW votes_by_big_cities AS
SELECT 	sr.county,
        bct.latitude,
        bct.longitude,
        ROUND(sr.andrzej_duda / sr.number_of_votes * 100, 2) as DudaVotesPercent,
        ROUND(sr.rafal_trzaskowski / sr.number_of_votes * 100, 2) as TrzaskowskiVotesPercent
FROM second_round as sr
JOIN big_cities_poland as bct ON sr.county = bct.city_name
ORDER BY county;

-- VIEW Votes by voivodeship (2 round)
DROP VIEW IF EXISTS votes_by_voivodeship;
CREATE VIEW votes_by_voivodeship AS
SELECT 	voivodeship,
        ROUND(SUM(rafal_trzaskowski) / SUM(number_of_votes) * 100, 2) as TrzaskowskiVotesPercent,
        ROUND(SUM(andrzej_duda) / SUM(number_of_votes) * 100, 2) as DudaVotesPercent
FROM second_round
GROUP BY voivodeship
ORDER BY voivodeship;

-- VIEW Average salaries by voivodeship
DROP VIEW IF EXISTS avg_salaries_voivodeship;
CREATE VIEW avg_salaries_voivodeship AS
SELECT 	ps.name,
        ps.avg_salary
FROM second_round as sr
RIGHT JOIN poland_salary as ps ON sr.zip_code = ps.code
WHERE zip_code IS NULL
ORDER BY ps.name;


-- VIEW Average salaries by county (excluding 'zagranica' (people who don't live in Poland))
DROP VIEW IF EXISTS avg_salaries_county;
CREATE VIEW avg_salaries_county AS
SELECT 	ps.code,
        ps.name,
	ps.avg_salary
FROM poland_salary as ps
RIGHT JOIN second_round as sr ON ps.code = sr.zip_code
WHERE sr.county <> 'zagranica'
ORDER BY ps.code;


-- VIEW Average salaries grouped by salary quartiles
-- (excluding 'zagranica' (people who don't live in Poland))
DROP VIEW IF EXISTS avg_salaries_county_grouped;
CREATE VIEW avg_salaries_county_grouped AS
WITH salary_quartiles AS (
    SELECT
        code,
        NTILE(4) OVER (ORDER BY avg_salary) AS salary_quartile
    FROM poland_salary
),
total_votes_all AS (
    SELECT SUM(number_of_votes) AS all_votes
    FROM second_round
    WHERE county <> 'zagranica'
)
SELECT
    sq.salary_quartile,
    ROUND(SUM(sr.number_of_votes) * 100.0 / tva.all_votes, 2) AS total_votes_percent,
    ROUND(AVG(sr.rafal_trzaskowski * 100.0 / sr.number_of_votes), 2) AS avg_trzaskowski_percent,
    ROUND(AVG(sr.andrzej_duda * 100.0 / sr.number_of_votes), 2) AS avg_duda_percent
FROM salary_quartiles sq
JOIN second_round sr ON sq.code = sr.zip_code
CROSS JOIN total_votes_all tva
WHERE sr.county <> 'zagranica'
GROUP BY sq.salary_quartile, tva.all_votes
ORDER BY sq.salary_quartile;

