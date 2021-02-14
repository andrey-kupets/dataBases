# 1. +Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.

SELECT * FROM client WHERE LENGTH(FirstName) < 6;

# 2. +Вибрати львівські відділення банку.+

SELECT * FROM department WHERE DepartmentCity = 'LVIV';

# 3. +Вибрати клієнтів з вищою освітою та посортувати по прізвищу.

SELECT * FROM client WHERE Education = 'HIGH' ORDER BY LastName;

# 4. +Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.

SELECT * FROM application  ORDER BY idApplication DESC LIMIT 5 OFFSET 10;

# 5. +Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.

SELECT * FROM client WHERE LastName LIKE '%OV' OR LastName LIKE '%OVA'; # HOW MAKE IT SHORTLY?

# 6. +Вивести клієнтів банку, які обслуговуються київськими відділеннями.

SELECT * FROM client
    JOIN department ON client.Department_idDepartment = department.idDepartment
    WHERE DepartmentCity = 'Kyiv';

# 7. +Вивести імена клієнтів та їхні номера телефону, погрупувавши їх за іменами.

SELECT FirstName, Passport FROM client; # use passport instead phone - VK

# 8. +Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.

SELECT * FROM client
    JOIN application ON idClient = application.Client_idClient
    WHERE SUM > 5000;

# 9. +Порахувати кількість клієнтів усіх відділень та лише львівських відділень.

SELECT COUNT(idClient) FROM client c
    JOIN department d on c.Department_idDepartment = d.idDepartment
UNION
SELECT COUNT(idClient) FROM client c
    JOIN department d on c.Department_idDepartment = d.idDepartment
    WHERE DepartmentCity = 'LVIV';

# 10. Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.

SELECT MAX(Sum) maxSum, FirstName, LastName FROM application
JOIN client on idClient = application.Client_idClient
GROUP BY idClient;

# 11. Визначити кількість заявок на крдеит для кожного клієнта.

SELECT COUNT(idClient), FirstName, LastName FROM client c
JOIN application a on c.idClient = a.Client_idClient
GROUP BY idClient;

# 12. Визначити найбільший та найменший кредити.

SELECT MAX(Sum) maxSum, MIN(Sum) minSum FROM application;

# 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.

SELECT COUNT(Sum) FROM client c
JOIN application a on c.idClient = a.Client_idClient
WHERE Education = 'HIGH'; # AND CreditState = 'NOT RETURNED';

# 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.

SELECT AVG(Sum) avgSum, FirstName, LastName, Passport FROM client
JOIN application a on client.idClient = a.Client_idClient
GROUP BY idClient
ORDER BY avgSum DESC
LIMIT 1;                            # HOW MAKE IT SHORTLY?

# 15. Вивести відділення, яке видало в кредити найбільше грошей

SELECT SUM(Sum) totalSum, DepartmentCity FROM department d
JOIN client c on d.idDepartment = c.Department_idDepartment
JOIN application a on c.idClient = a.Client_idClient
GROUP BY DepartmentCity
ORDER BY totalSum DESC LIMIT 1;

# 16. Вивести відділення, яке видало найбільший кредит.

SELECT MAX(Sum) maxSum, DepartmentCity, Department_idDepartment FROM department d
JOIN client c on d.idDepartment = c.Department_idDepartment
JOIN application a on c.idClient = a.Client_idClient;

# 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.

UPDATE application a
JOIN client c on c.idClient = a.Client_idClient
SET Sum = 6000
WHERE Education = 'HIGH';

# 18. Усіх клієнтів київських відділень пересилити до Києва.

UPDATE client c
JOIN department d on c.Department_idDepartment = d.idDepartment
SET City = 'Kyiv'
WHERE DepartmentCity = 'Kyiv';

# 19. Видалити усі кредити, які є повернені.

DELETE FROM application
WHERE CreditState = 'Returned';

# 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.

DELETE a FROM application a
JOIN client c on c.idClient = a.Client_idClient
WHERE LastName LIKE '_A%' OR
      LastName LIKE '_E' OR
      LastName LIKE '_I' OR
      LastName LIKE '_O' OR
      LastName LIKE '_U' OR
      LastName LIKE '_Y';


# OR...
# DELETE  FROM application WHERE Client_idClient IN
#                               (SELECT idClient from client WHERE REGEXP_LIKE(LastName, '^.[aeyuio].*$'));

# Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000

SELECT Department_idDepartment, DepartmentCity, SUM(Sum) totalSum FROM department d
JOIN client c on d.idDepartment = c.Department_idDepartment
JOIN application a on c.idClient = a.Client_idClient
WHERE DepartmentCity = 'Lviv'
GROUP BY idDepartment
HAVING totalSum > 5000;

# Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000

SELECT SUM(Sum) totalSum, FirstName, LastName FROM client c
JOIN application a on c.idClient = a.Client_idClient
WHERE CreditState = 'Returned'  # OR
GROUP BY idClient
HAVING totalSum > 5000;
# OR
# AND Sum = (SELECT SUM(Sum) > 5000 FROM application);
# OR
# AND Sum = (SELECT SUM(Sum) FROM application WHERE Sum > 5000);

/* Знайти максимальний неповернений кредит.*/

SELECT MAX(Sum) maxCredit FROM application
WHERE CreditState = 'NOT RETURNED';

/*Знайти клієнта, сума кредиту якого найменша*/

SELECT MIN(Sum) minSum,idClient, FirstName, LastName FROM client c
JOIN application a on c.idClient = a.Client_idClient
WHERE Sum = (SELECT MIN(Sum) FROM application); -- OR

# GROUP BY idClient
# ORDER BY minSum
# LIMIT 1;

/*Знайти кредити, сума яких більша за середнє значення усіх кредитів*/

SELECT idApplication, Sum avgCredit FROM application
WHERE Sum > (SELECT AVG(Sum) FROM application);

/*Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів*/

SELECT DISTINCT idClient, FirstName, LastName FROM client
JOIN application a on client.idClient = a.Client_idClient
WHERE City = (SELECT City FROM client
              JOIN application a2 on client.idClient = a2.Client_idClient
              GROUP BY idClient
              ORDER BY COUNT(idApplication) DESC
              LIMIT 1);

#місто чувака який набрав найбільше кредитів

SELECT City, Sum, COUNT(idApplication) creditsNumber FROM client
JOIN application a on client.idClient = a.Client_idClient
GROUP BY idClient
ORDER BY creditsNumber DESC
LIMIT 1;
