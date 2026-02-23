/*
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output should consist of four columns (Doctor, Professor, Singer, and Actor) in that specific order, with their respective names listed alphabetically under each column.

Note: Print NULL when there are no more names corresponding to an occupation.
*/

SET NOCOUNT ON;

SELECT [Doctor], [Professor], [Singer], [Actor]	--there will be corresponding columns in new table
FROM (	
    SELECT 
        Name, 
        Occupation, 
        ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS RowNum		--the names are sectioned for corresponding occupation, and then ordered
    FROM OCCUPATIONS
) AS SourceTable						--it is compulsory to use aliases
PIVOT (
    MAX(Name)					--because pivot needs aggregation
    FOR Occupation IN ([Doctor], [Professor], [Singer], [Actor])	--defines column header for  PivotTable	
) AS PivotTable;

go


--------------------------------------------------------------------------
--BINARY TREE NODES
/*You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

    Root: If node is root node.
    Leaf: If node is leaf node.
    Inner: If node is neither root nor leaf node.
*/
SET NOCOUNT ON;

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

SELECT N,
    CASE
        WHEN P is null THEN 'Root'
        WHEN N in (SELECT P FROM bst WHERE P is not null) THEN 'Inner'
        ELSE 'Leaf'
    END
FROM bst
ORDER BY N ;

go

-----------------------------------------------------------------------------------------------------------------
--NEW COMPANIES

/*Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy:

Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

Note:

    The tables may contain duplicate records.
    The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.
*/

SET NOCOUNT ON;

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

select 
    cmp.company_code,
    cmp.founder,
    COUNT( distinct l_mg.lead_manager_code),
    COUNT(distinct s_mg.senior_manager_code),
    COUNT(distinct mg.manager_code),
    COUNT(distinct emp.employee_code)
    
from Company as cmp
JOIN Lead_Manager as l_mg ON l_mg.company_code = cmp.company_code 
JOIN Senior_Manager as s_mg ON S_mg.company_code = cmp.company_code
JOIN Manager as mg ON mg.company_code = cmp.company_code
JOIN Employee as emp ON emp.company_code = cmp.company_code
group by	
    cmp.company_code,	--because of aggregation function COUNT
    cmp.founder		--because of aggregation function COUNT
order by cmp.company_code ASC
;
go
