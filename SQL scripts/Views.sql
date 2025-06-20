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
SELECT 	sr.county,
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