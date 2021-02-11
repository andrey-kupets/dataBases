INSERT INTO `september-2020`.cars VALUE (DEFAULT, 'Mazda'); # id = DEFAULT

SELECT *
FROM students;

select name, age
from students;

SELECT *
FROM students
WHERE age = 15;
SELECT *
FROM students
WHERE name = 'ROMAN';
SELECT *
FROM students
WHERE name LIKE '%AN';
SELECT *
FROM students
WHERE name LIKE 'O%';
SELECT *
FROM students
WHERE name LIKE '%E%';
SELECT *
FROM students
WHERE name LIKE '___A%';
SELECT *
FROM students
WHERE LENGTH(NAME) = 4;
SELECT *
FROM students
WHERE name LIKE 'O%'
ORDER BY AGE DESC;
SELECT *
FROM students
ORDER BY age ASC;
SELECT *
FROM students
WHERE age != 20;
SELECT *
FROM students
WHERE age <> 20;
SELECT *
FROM students
WHERE age >= 20;
SELECT *
FROM students
WHERE age BETWEEN 20 AND 31; # OR
SELECT *
FROM students
WHERE age >= 20
  AND age <= 31;

SELECT *
FROM students
WHERE age > 18
  AND NAME LIKE 'O%';
SELECT *
FROM students
WHERE age = 18
   OR name LIKE 'O%' AND gender = 'FEMALE'; # OR
SELECT *
FROM students
WHERE age = 18
   OR name LIKE 'O%' AND gender LIKE 'F%';
SELECT *
FROM students
WHERE age BETWEEN 20 AND 31
   OR name LIKE 'o%';

SELECT *
FROM students
WHERE age IN (20, 25, 30, 35);

# AGGREGATE FUNCTIONS:

SELECT MAX(age) AS maxAGE
FROM students; # DON'T LEAVE MAX(AGE) --- BAD FOR NODE
SELECT MIN(age) AS minAGE
FROM students;
SELECT AVG(age) AS avgAGE
FROM students;
SELECT COUNT(ID)
FROM students;
SELECT COUNT(id)
FROM students
WHERE age > 50;
SELECT SUM(age)
FROM students;
SELECT *
FROM students
WHERE age = (SELECT MAX(age) FROM students);

SELECT AVG(rating) AS avgRat,
       COUNT(rating) AS countRat
FROM ratings
WHERE student_id = 5;

# limits and offsets

SELECT * FROM students ORDER BY age LIMIT 3;
SELECT * FROM students ORDER BY age LIMIT 3 OFFSET 3;
SELECT * FROM students LIMIT 3 OFFSET 9;

# UPDATES

UPDATE students SET NAME = 'BUHARIK', gender = 'MURLO' WHERE age = 20;
UPDATE students SET NAME = 'MOROZ' WHERE age = 25;
UPDATE students SET age = 20 WHERE age >= 40;

DELETE FROM students WHERE gender = 'BREHLO';
DELETE FROM students WHERE name = 'MOROZ';

