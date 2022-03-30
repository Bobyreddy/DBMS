
-- 1. Count the customers with grades above Bangalore’s average.

SELECT GRADE, COUNT(DISTINCT CUSTOMER_ID) FROM CUSTOMER GROUP BY GRADE HAVING GRADE > ( SELECT AVG(GRADE) FROM CUSTOMER WHERE CITY='BANGALORE' ) ;

-- 2. Find the name and numbers of all salesmen who had more than onecustomer.

SELECT SALESMAN_ID, NAME FROM SALESMAN A WHERE 1 < (SELECT COUNT (*) FROM CUSTOMER WHERE SALESMAN_ID = A.SALESMAN_ID);

-- 3. List allsalesmen and indicate those who have and don’t have customersin their cities (Use UNION operation.)

SELECT SALESMAN.SALESMAN_ID, NAME, CUST_NAME, COMMISSION FROM SALESMAN, CUSTOMER1 WHERE SALESMAN.CITY = CUSTOMER1.CITY UNION SELECT SALESMAN_ID, NAME, 'NO MATCH', COMMISSION FROM SALESMAN WHERE NOT CITY = ANY (SELECT CITY FROM CUSTOMER1) ORDER BY 2 DESC;

-- 4. Create a view thatfindsthe salesman who hasthe customer with the highest order of aday.

CREATE VIEW ELITSALESMAN AS SELECT B.ORD_DATE, A.SALESMAN_ID, A.NAME FROM SALESMAN A, ORDERS B

-- 5. Demonstrate theDELETEoperationbyremovingsalesmanwithid1000.Allhis orders must also be deleted.

DELETE FROM SALESMAN WHERE SALESMAN_ID=1000;

