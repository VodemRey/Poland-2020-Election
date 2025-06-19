-- Delete '0' from the beginning and code end from poland_salary.code
UPDATE poland_salary
SET code = SUBSTRING(code, 2)
WHERE code LIKE '0%';

UPDATE poland_salary
SET code = LEFT(code, LENGTH(code) - 1)
WHERE code LIKE '%0';

-- Setting appropriate zip-code to Warszawa
UPDATE second_round
SET zip_code = 146500
WHERE zip_code = 146501;

-- Deleting 'statki' from second round (minor error)
DELETE FROM second_round
WHERE county = 'statki';

--
UPDATE poland_salary
SET name = 'zamosc'
WHERE code = 66400;