use crowdfunding;
select count(*) from calender;
select count(*) from creator;
select count(*) from main;
select count(*) from location;
select count(*) from category;

/*Total Number of Projects based on outcome*/
select state,count(id) as "TOTAL NO OF PROJECTS"
from main
group by state;

/*Total Number of Projects based on Locations*/
SELECT LOCATION.NAME,COUNT(MAIN.ID)
FROM MAIN INNER JOIN LOCATION
ON MAIN.LOCATION_ID=LOCATION.ID
GROUP BY LOCATION.NAME
ORDER BY COUNT(MAIN.ID) DESC
LIMIT 10;

/*Total Number of Projects based on Category*/
SELECT CATEGORY.NAME,COUNT(MAIN.ID)
FROM MAIN INNER JOIN CATEGORY
ON MAIN.CATEGORY_ID=CATEGORY.ID
GROUP BY CATEGORY.NAME
ORDER BY COUNT(MAIN.ID) DESC
LIMIT 10;

/*Total Number of Projects created by Year*/
SELECT YEAR,COUNT(MAIN.ID)
FROM MAIN INNER JOIN CALENDER
ON MAIN.ID=CALENDER.ID
GROUP BY YEAR
ORDER BY COUNT(MAIN.ID) DESC;

/*Total Number of Projects created by MONTH*/
SELECT MONTHFULLNAME,COUNT(MAIN.ID)
FROM MAIN INNER JOIN CALENDER
ON MAIN.ID=CALENDER.ID
GROUP BY MONTHFULLNAME;

/*Total Number of Projects created by MONTH*/
SELECT QUARTER,COUNT(MAIN.ID)
FROM MAIN INNER JOIN CALENDER
ON MAIN.ID=CALENDER.ID
GROUP BY QUARTER
ORDER BY QUARTER;

/*Successful Projects by Amount Raised*/
select name,usd_pledged
from main
where state in("successful")
order by usd_pledged desc
limit 10;

/*Successful Projects by Number of Backers*/
select name,backers_count
from main
where state in("successful")
order by backers_count desc
limit 10;

/*Percentage of Successful Projects overall*/
select state, CONCAT((select count(id)
                from main
                where state in("successful"))/(select count(id)
                                               from main)*100,'%') as "% OF SUCCESSFUL PROJECTS" 
                                               
from main
WHERE STATE IN("SUCCESSFUL")
group by state;

/*Percentage of Successful Projects  by Category*/

SELECT 
  CATEGORY.NAME AS Category,
  CONCAT(ROUND(
  (SUM(CASE WHEN MAIN.STATE = 'successful' THEN 1 ELSE 0 END) * 100.0) / COUNT(MAIN.ID),
      2
    ), '%'
  ) AS "% of Successful Projects"
FROM MAIN
INNER JOIN CATEGORY ON MAIN.CATEGORY_ID = CATEGORY.ID
GROUP BY CATEGORY.NAME
ORDER BY 
  (SUM(CASE WHEN MAIN.STATE = 'successful' THEN 1 ELSE 0 END) * 100.0) / COUNT(MAIN.ID) DESC;

/*Percentage of Successful Projects  by Year*/

SELECT YEAR,
  CONCAT(
    ROUND(
      (SUM(CASE WHEN MAIN.STATE = 'successful' THEN 1 ELSE 0 END) * 100.0) / COUNT(MAIN.ID),
      2
    ), '%'
  ) AS "% of Successful Projects"
FROM MAIN
INNER JOIN CALENDER ON MAIN.ID = CALENDER.ID
GROUP BY YEAR
ORDER BY YEAR;

/*Percentage of Successful Projects  by Year*/
SELECT MONTHFULLNAME,
  CONCAT(
    ROUND(
      (SUM(CASE WHEN MAIN.STATE = 'successful' THEN 1 ELSE 0 END) * 100.0) / COUNT(MAIN.ID),
      2
    ), '%'
  ) AS "% of Successful Projects"
FROM MAIN
INNER JOIN CALENDER ON MAIN.ID = CALENDER.ID
GROUP BY MONTHFULLNAME;

/*Percentage of Successful Projects  by GOAL RANGE*/

SELECT GOAL_RANGE,
  CONCAT(
    ROUND(
      (SUM(CASE WHEN MAIN.STATE = 'successful' THEN 1 ELSE 0 END) * 100.0) / COUNT(MAIN.ID),
      2
    ), '%'
  ) AS "% of Successful Projects"
FROM MAIN
GROUP BY GOAL_RANGE;

