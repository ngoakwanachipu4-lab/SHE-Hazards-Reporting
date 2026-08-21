-------------------------------------------------------------------
---1. Checking the data
-------------------------------------------------------------------
select * from `workspace`.`default`.`she_observations` limit 100;
--------------------------------------------------------------------
---2. Checking the dates
---------------------------------------------------------------------
SELECT MIN(`date of occurrence`) AS Minimum_Date,
       MAX(`date of occurrence`) AS Maximum_Date
from `workspace`.`default`.`she_observations`;
-------------------------------------------------------------------
---3. Checking observations per operation
------------------------------------------------------------------
SELECT 
    operation,
    COUNT(*) AS total_observations
from `workspace`.`default`.`she_observations`
GROUP BY operation
ORDER BY total_observations DESC;
----------------------------------------------------------
---4. Checking Observationss----
----------------------------------------------------------
SELECT 
    DATE_FORMAT(`date of occurrence`, 'yyyy-MM') AS reporting_month,
    COUNT(*) AS observations
from `workspace`.`default`.`she_observations`
GROUP BY reporting_month
ORDER BY reporting_month;

-------------------------------------------------
---5. Top 10 Most Common SHE Issues
-------------------------------------------------
SELECT 
    title,
    COUNT(*) AS issue_count
from `workspace`.`default`.`she_observations`
GROUP BY title
ORDER BY issue_count DESC
LIMIT 10;

--------------------------------------------------
---5. Reporting Trend During the month
---Beginning/Mid/End Month
--------------------------------------------------

SELECT 
    CASE
        WHEN DAY(`date of occurrence`) BETWEEN 1 AND 10 THEN 'Beginning'
        WHEN DAY(`date of occurrence`) BETWEEN 11 AND 20 THEN 'Mid-Month'
        ELSE 'End-Month'
    END AS reporting_period,
    COUNT(*) AS total_reports
from `workspace`.`default`.`she_observations`
GROUP BY reporting_period
ORDER BY total_reports DESC;

-----------------------------------------------------------------
---6. Suboperation with highest reports
-----------------------------------------------------------------
SELECT operation,
       `sub operation`,
       COUNT(*) AS total_reports
from `workspace`.`default`.`she_observations`
GROUP BY operation, `sub operation`
ORDER BY total_reports;      

---------------------------------------------------------------------
---7. Drilling observations in Angola
---------------------------------------------------------------------
SELECT
     `date of occurrence`,
     title,
     description,
     `immediate action taken`
 from `workspace`.`default`.`she_observations`
 WHERE LOWER(TRIM(operation)) = 'angola'
 AND LOWER(TRIM(`sub operation`)) = 'drilling (core & lld)'
 ORDER BY `date of occurrence` DESC;   


SELECT
     `date of occurrence`,
     title,
     description,
     `immediate action taken`
 from `workspace`.`default`.`she_observations`
 WHERE  operation = 'Angola'
 AND `sub operation` = 'Field Facilities'
 ORDER BY `date of occurrence` DESC;   


SELECT DISTINCT `sub operation`
from `workspace`.`default`.`she_observations`
ORDER BY 1;

SELECT COUNT(*)
from `workspace`.`default`.`she_observations`
WHERE operation ='Angola';


SELECT COUNT(*)
from `workspace`.`default`.`she_observations`
WHERE `sub operation` = 'Field Facilities';
 ------------------------------------------------
---8. Drilling observations in May
---Angola =26, Botswana = 12; RSA Support Services = 6
-----------------------------------------------------
SELECT
 operation,
    COUNT(*) AS total_observations
from `workspace`.`default`.`she_observations`
WHERE operation = 'Angola'
AND MONTH(`date of occurrence`) = 5
GROUP BY operation;

SELECT
 operation,
 `sub operation`,
    COUNT(*) AS total_observations
from `workspace`.`default`.`she_observations`
WHERE operation = 'Angola'
AND `sub operation` = 'Field Activities'
AND MONTH(`date of occurrence`) = 5
GROUP BY operation, `sub operation`;  

SELECT
 operation,
    COUNT(*) AS total_observations
from `workspace`.`default`.`she_observations`
WHERE operation = 'Botswana'
AND MONTH(`date of occurrence`) = 5
GROUP BY operation;


SELECT
 operation,
    COUNT(*) AS total_observations
from `workspace`.`default`.`she_observations`
WHERE operation = 'RSA Support Services'
AND MONTH(`date of occurrence`) = 5
GROUP BY operation;


--------------------------------------------------
---9. Most Common Safety Issues
---Housekeeping 21, electrical 6, water leaks 1, waste management 3, ERP 5, poor road conditions 17
--------------------------------------------------
SELECT
     operation,
     `sub operation`,
     title,
     description
from `workspace`.`default`.`she_observations`
WHERE title LIKE '%Housekeeping%'
    OR description LIKE '%housekeeping%';
-------------------------------------------------------
---FULL SQL CODE for Observations
-----------------------------------------------------------
SELECT
     operation,
     `sub operation`,
     title,
     description
from `workspace`.`default`.`she_observations`
WHERE title LIKE '%electrical%'
    OR description LIKE '%electrical%';

  SELECT
     operation,
     `sub operation`,
     title,
     description
from `workspace`.`default`.`she_observations`
WHERE title LIKE '%water leaks%'
    OR description LIKE '%water leaks%';  


   SELECT
     operation,
     `sub operation`,
     title,
     description
from `workspace`.`default`.`she_observations`
WHERE title LIKE '%waste management%'
    OR description LIKE '%waste management%';   


    
   SELECT
     operation,
     `sub operation`,
     title,
     description
from `workspace`.`default`.`she_observations`
WHERE title LIKE '%Ermegency%'
    OR description LIKE '%ERP%'
    OR description LIKE '%ERT%';   

SELECT
     operation,
     `sub operation`,
     title,
     description
from `workspace`.`default`.`she_observations`
WHERE title LIKE '%road%'
    OR description LIKE '%road%'
    OR description LIKE '%poor road conditions';

SELECT
     operation,
     title,
     description
from `workspace`.`default`.`she_observations`
WHERE title LIKE '%snakes%'
    OR description LIKE '%scorpins%'
    OR description LIKE '%spider%'
    OR description LIKE '%wasp%'
    OR description LIKE '%bee%'
    OR description LIKE '%rodents%';

  

SELECT 
    CASE
        WHEN title LIKE '%Good%'
          OR title LIKE '%Positive%'
          OR title LIKE '%Safe%'
        THEN 'Positive Observation'
        ELSE 'Negative Observation'
    END AS observation_category,
    COUNT(*) AS total
from `workspace`.`default`.`she_observations`
GROUP BY observation_category;

-------------------------------------------------------------
---

SELECT 
    operation,
    COUNT(*) AS month_end_reports
from `workspace`.`default`.`she_observations`
WHERE DAY(`date of occurrence`) >= 21
GROUP BY operation
ORDER BY month_end_reports DESC;



SELECT 
    `specific location`,
    COUNT(*) AS total_reports
FROM she_observations
GROUP BY `specific location`
ORDER BY total_reports DESC
LIMIT 10;

--------------------------------------------------
---Master  
--------------------------------------------------


SELECT
        id,
        operation,
        `sub operation`,
        `specific location`,
        department,
        title,
        description,
        `immediate action taken`,
        DATE_FORMAT(`date of occurrence`, 'yyyy-MM-dd') AS occurrence_date,
        CASE
            WHEN LOWER(description) LIKE '%housekeeping%'
              OR LOWER(description) LIKE '%slips trip & fall%'
              OR LOWER(description) LIKE '%snake%'
              OR LOWER(description) LIKE '%scorpion%'
              OR LOWER(description) LIKE '%spider%'
              OR LOWER(description) LIKE '%wasp%'
              OR LOWER(description) LIKE '%bee%'
              OR LOWER(description) LIKE '%rodent%'
              OR LOWER(description) LIKE '%electrical%'
              OR LOWER(title) LIKE '%electrical%'
              OR LOWER(description) LIKE '%lighting%'
              OR LOWER(description) LIKE '%fire%'
              OR LOWER(description) LIKE '%extinguisher%'
              OR  LOWER(description) LIKE '%vehicle%'
              OR LOWER(description) LIKE '%road%'
              OR LOWER(description) LIKE '%driving%'
              OR LOWER(description) LIKE '%ppe%'
          
                 THEN 'Safety'

            WHEN LOWER(description) LIKE '%chemical%'
              OR LOWER(description) LIKE '%spill%'
              OR LOWER(description) LIKE '%gas cylinder%'
              OR LOWER(description) LIKE '%waste%'
              OR LOWER(description) LIKE '%resource waste%'
              OR LOWER(description) LIKE '%Water%'
              OR LOWER(description) LIKE '%Safety Data Sheet%'
                THEN 'Environmental' 
            
            WHEN LOWER(description) LIKE '%hygiene%'
              OR LOWER(description) LIKE '%food%'
              OR LOWER(description) LIKE '%flies%'
              OR LOWER(description) LIKE '%Toilets%'
              OR LOWER(description) LIKE '%Showers%'
              OR LOWER(description) LIKE '%Kitchen%'
              OR LOWER(description) LIKE '%Catering%'
                THEN 'Health / Hygiene'

            WHEN LOWER(description) LIKE '%erp%'
              OR LOWER(description) LIKE '%emergency%'
              OR LOWER(description) LIKE '%aed%'
              OR LOWER(description) LIKE '%first aiders%'
              OR LOWER(description) LIKE '%ERD%'
                THEN 'Emergency Preparedness'
            ELSE 'Other'
        END AS issue_category,
        CASE
            WHEN DAY(`date of occurrence`) BETWEEN 1 AND 10 THEN 'Beginning'
        WHEN DAY(`date of occurrence`) BETWEEN 11 AND 20 THEN 'Mid-Month'
        ELSE 'End-Month'
        END AS reporting_period,
        CASE
            WHEN title LIKE '%Good%'
          OR title LIKE '%Positive%'
          OR title LIKE '%Congratulations%'
          OR title LIKE '%Well done%'
        THEN 'Positive Observation'
        ELSE 'Negative Observation'
        END AS observation_category
    FROM `workspace`.`default`.`she_observations`;

    -----------------------------------------------
---Final SQL
------------------------------------------------------

WITH enriched_observations AS (
    SELECT
        id,
        operation,
        `sub operation`,
        `specific location`,
        department,
        title,
        description,
        `immediate action taken`,
        DATE_FORMAT(`date of occurrence`, 'yyyy-MM-dd') AS occurrence_date,
        CASE
            WHEN LOWER(description) LIKE '%housekeeping%'
              OR LOWER(description) LIKE '%slips trip & fall%'
              OR LOWER(description) LIKE '%snake%'
              OR LOWER(description) LIKE '%scorpion%'
              OR LOWER(description) LIKE '%spider%'
              OR LOWER(description) LIKE '%wasp%'
              OR LOWER(description) LIKE '%bee%'
              OR LOWER(description) LIKE '%rodent%'
              OR LOWER(description) LIKE '%electrical%'
              OR LOWER(title) LIKE '%electrical%'
              OR LOWER(description) LIKE '%lighting%'
              OR LOWER(description) LIKE '%fire%'
              OR LOWER(description) LIKE '%extinguisher%'
              OR  LOWER(description) LIKE '%vehicle%'
              OR LOWER(description) LIKE '%road%'
              OR LOWER(description) LIKE '%driving%'
              OR LOWER(description) LIKE '%ppe%'
                 THEN 'Safety'
            WHEN LOWER(description) LIKE '%chemical%'
              OR LOWER(description) LIKE '%spill%'
              OR LOWER(description) LIKE '%gas cylinder%'
              OR LOWER(description) LIKE '%waste%'
              OR LOWER(description) LIKE '%resource waste%'
              OR LOWER(description) LIKE '%Water%'
              OR LOWER(description) LIKE '%Safety Data Sheet%'
                THEN 'Environmental' 
            WHEN LOWER(description) LIKE '%hygiene%'
              OR LOWER(description) LIKE '%food%'
              OR LOWER(description) LIKE '%flies%'
              OR LOWER(description) LIKE '%Toilets%'
              OR LOWER(description) LIKE '%Showers%'
              OR LOWER(description) LIKE '%Kitchen%'
              OR LOWER(description) LIKE '%Catering%'
                THEN 'Health / Hygiene'
            WHEN LOWER(description) LIKE '%erp%'
              OR LOWER(description) LIKE '%emergency%'
              OR LOWER(description) LIKE '%aed%'
              OR LOWER(description) LIKE '%first aiders%'
              OR LOWER(description) LIKE '%ERD%'
                THEN 'Emergency Preparedness'
            ELSE 'Other'
        END AS issue_category,
        CASE
            WHEN DAY(`date of occurrence`) BETWEEN 1 AND 10 THEN 'Beginning'
            WHEN DAY(`date of occurrence`) BETWEEN 11 AND 20 THEN 'Mid-Month'
            ELSE 'End-Month'
        END AS reporting_period,
        DATE_FORMAT(`date of occurrence`, 'yyyy-MM') AS report_month,
        CASE
            WHEN title LIKE '%Good%'
              OR title LIKE '%Positive%'
              OR title LIKE '%Congratulations%'
              OR title LIKE '%Well done%'
            THEN 'Positive Observation'
            ELSE 'Negative Observation'
        END AS observation_category
    FROM `workspace`.`default`.`she_observations`
)
