------------------------------------------------------------------------------------------------------------------
--Revising Aggregations - The Count Function

SET NOCOUNT ON;

SELECT  
    COUNT(1)
FROM CITY
WHERE
    population > 100000
;

go

------------------------------------------------------------------------------------------------------------------
--The Sum Function
SET NOCOUNT ON;

SELECT 
    SUM(population)
FROM 
    CITY
WHERE
    district = 'California'
;
go
------------------------------------------------------------------------------------------------------------------
--Avereges
SET NOCOUNT ON;

SELECT
    AVG(population)
FROM 
    CITY
WHERE
    district = 'California'
;

go
------------------------------------------------------------------------------------------------------------------
-- Average Population
SET NOCOUNT ON;

SELECT
    ROUND(AVG(population),0)
FROM city
;

go
------------------------------------------------------------------------------------------------------------------
--Japan Population
SET NOCOUNT ON;

SELECT 
    SUM(population)
FROM CITY
WHERE countrycode = 'JPN'
;

go
------------------------------------------------------------------------------------------------------------------
-- Population Density Difference
SET NOCOUNT ON;

SELECT
    MAX(population) - MIN(population)
FROM city
;

go
------------------------------------------------------------------------------------------------------------------
--The Blunder
SET NOCOUNT ON;

SELECT
    CAST(CEILING(
        AVG(CAST(salary AS FLOAT))
        - AVG(CAST(REPLACE(CAST(salary AS VARCHAR), '0', '') AS FLOAT))
    ) AS INTEGER)
FROM
    employees
;
go
------------------------------------------------------------------------------------------------------------------
-- Top Earners
SET NOCOUNT ON;

SELECT TOP 1
    (months * salary), 
    COUNT(*) 
FROM 
    Employee 
GROUP BY 
    (months * salary) 
ORDER BY 
    (months * salary) DESC 
;
go
------------------------------------------------------------------------------------------------------------------
--Weather Observation Station 2
SET NOCOUNT ON;

SELECT
    CAST(SUM(LAT_N) AS DECIMAL(10, 2)),
    CAST(SUM(LONG_W) AS DECIMAL(10, 2))
FROM station
;
go
------------------------------------------------------------------------------------------------------------------
-- Weather Observation Station 13
SET NOCOUNT ON;

SELECT
    CAST(SUM(LAT_N) AS DECIMAL(10,4))
FROM station
WHERE LAT_N BETWEEN 38.7880 AND 137.2345
;
go
------------------------------------------------------------------------------------------------------------------
-- Weather Observation Station 14
SET NOCOUNT ON;

SELECT
    CAST(MAX(LAT_N) AS DECIMAL(10,4))
FROM station
WHERE LAT_N < 137.2345

go
------------------------------------------------------------------------------------------------------------------
--Weather Observation Station 15

SELECT TOP 1
    CAST(LONG_W AS DECIMAL(10,4))
from station
WHERE lat_n < 137.2345
ORDER BY lat_n DESC
;
go
------------------------------------------------------------------------------------------------------------------
--Weather Observation Station 16
SET NOCOUNT ON;

SELECT TOP 1
    CAST(lat_n AS DECIMAL(10,4))
FROM station
WHERE lat_n > 38.7780 
ORDER BY lat_n
;
go
------------------------------------------------------------------------------------------------------------------
--Weather Observation Station 17
SET NOCOUNT ON;

SELECT TOP 1
    CAST(long_w AS DECIMAL(10,4))
FROM station
WHERE lat_n > 38.7780
order by lat_n ASC

go

------------------------------------------------------------------------------------------------------------------
--Weather Observation Station 18
SET NOCOUNT ON;

SELECT
    CAST(ABS(MAX(lat_n) - MIN(lat_n))+ABS(MAX(long_w)-MIN(long_w)) AS DECIMAL(10,4))    
FROM station

;

go

------------------------------------------------------------------------------------------------------------------
--Weather Observation Station 19
SET NOCOUNT ON;

SELECT
    CAST(SQRT(POWER(MAX(lat_n)-MIN(lat_n),2) + POWER(MAX(long_w)-MIN(long_w),2)) AS DECIMAL(10,4))
FROM station
;
go
------------------------------------------------------------------------------------------------------------------
--Weather Observation Station 20
SET NOCOUNT ON;

SELECT DISTINCT
    CAST((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY lat_n) OVER()) AS DECIMAL(10,4))
FROM station
;
go
------------------------------------------------------------------------------------------------------------------
--Weather Observation Station 
------------------------------------------------------------------------------------------------------------------
--Weather Observation Station 
