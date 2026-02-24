--POPULATION CENSUS

SET NOCOUNT ON;

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

select SUM(cit.population)
from city as cit
inner join country as ctr ON ctr.code = cit.countrycode
where cit.population is not null 
    and ctr.continent = 'Asia'
;
go
------------------------------------------------------------------------------------------------------------------
--African Cities
SET NOCOUNT ON;

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

select cit.name
from city as cit
JOIN country as ctr ON ctr.code = cit.CountryCode
where ctr.continent = 'Africa'
;
go

------------------------------------------------------------------------------------------------------------------
--Average population of each continent
SET NOCOUNT ON;

select ctr.continent,
    FLOOR(AVG(cit.population))
from city as cit
JOIN country as ctr ON ctr.code = cit.CountryCode
group by ctr.continent
go

------------------------------------------------------------------------------------------------------------------
-- The Report

SET NOCOUNT ON;

select
    case
        when g.grade < 8 THEN null
        else s.name 
    end as name,
    g.grade,
    s.marks
    
from students as s
JOIN grades as g ON 
    s.marks BETWEEN g.MIN_Mark AND g.Max_Mark
order by 
    g.grade DESC,
    s.name ASC,
    s.marks ASC;
go
------------------------------------------------------------------------------------------------------------------
-- Top Competitor
SET NOCOUNT ON;


select 
    h.hacker_id,
    h.name
from submissions s
JOIN Hackers as h ON s.hacker_id = h.hacker_id
JOIN challenges as ch ON s.challenge_id = ch.challenge_id
JOIN Difficulty as dif ON 
    dif.score = s.score
    and dif.Difficulty_level = ch.Difficulty_level
    
group by h.hacker_id, h.name
having 
    COUNT(s.challenge_id) > 1
ORDER BY
    COUNT(s.challenge_id) DESC,
    h.hacker_id ASC
go

------------------------------------------------------------------------------------------------------------------
--Ollivander's Inventory

--simple subquerry verision

SET NOCOUNT ON;

SELECT
    w.id,
    wp.age,
    w.coins_needed,
    w.power
FROM wands as w
join WANDS_PROPERTY AS wp ON 
    w.code = wp.code
WHERE   
    wp.is_evil = 0
    and w.coins_needed = 
        (SELECT MIN(w2.coins_needed)
        from wands as w2
        JOIN WANDS_PROPERTY as wp2 ON w2.code = wp2.code
        where wp2.age = wp.age and w2.power = w.power       
        )
    
ORDER BY 
    w.power  DESC,
    wp.age DESC
;
go

------------------------------------------------------------------------------------------------------------------
--Challenges

SET NOCOUNT ON;

SELECT 
    h.hacker_id,
    h.name,
    COUNT(ch.challenge_id)
FROM hackers as h
JOIN challenges as ch ON ch.hacker_id = h.hacker_id
GROUP BY
    h.hacker_id,
    h.name
HAVING
    COUNT(ch.challenge_id) = 
        (select TOP 1 COUNT(challenge_id)
            FROM challenges
            GROUP BY 
                hacker_id
            ORDER BY COUNT(challenge_id) DESC
        )
    OR COUNT(ch.challenge_id) IN
        (
            SELECT n_challenges2
            FROM(
                SELECT COUNT(challenge_id) as n_challenges2
                FROM challenges
                GROUP BY hacker_id) as chall_tab
            GROUP BY n_challenges2
            HAVING COUNT(n_challenges2) = 1
        )
ORDER BY 
    COUNT(ch.challenge_id) DESC,
    h.hacker_id

;
go

------------------------------------------------------------------------------------------------------------------
--Contest Leaderboard
SET NOCOUNT ON;



SELECT 
    h.hacker_id,
    h.name,
    SUM(s.score)
FROM hackers as h
JOIN 
    (SELECT hacker_id, challenge_id, MAX(score) as score
    FROM submissions
    GROUP BY
        hacker_id, challenge_id)
    as s ON h.hacker_id = s.hacker_id
GROUP BY     
    h.hacker_id,
    h.name
HAVING
    SUM(s.score) > 0
ORDER BY
    SUM(s.score) DESC,
    h.hacker_id ASC
;





go
