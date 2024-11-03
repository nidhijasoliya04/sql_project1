-- Selecting leading causes of death segmented by age groups, gender, and race for demographic insights
SELECT 
    a.code AS age_group,
    d.sex,
    r.code,
    c.code as death_cause,
    COUNT(d.resident_status) AS death_count
FROM 
    deaths AS d
LEFT JOIN
	`358_cause_recode` as c
ON 
	d.`358_cause_recode` = c.id
LEFT JOIN
	race as r
ON 
	d.`race` = r.id
LEFT JOIN
	age_recode_12 as a
ON 
	d.age_recode_12 = a.id
GROUP BY 
    d.age_recode_12, d.sex, d.race, d.`358_cause_recode`, c.code, r.code, a.code
ORDER BY 
    death_count DESC;
   
   
   
   
-- Identifying mortality trends for specific conditions over time
SELECT 
    d.current_data_year AS year,
    c.code AS cause_of_death,
    COUNT(d.resident_status) AS death_count
FROM 
    deaths AS d
LEFT JOIN 
    `358_cause_recode` AS c ON d.`358_cause_recode` = c.id
GROUP BY 
    d.current_data_year, c.code
ORDER BY 
    d.current_data_year, death_count DESC;




-- Analyzing seasonal mortality patterns for homicide
SELECT 
    d.month_of_death AS month,
    c.code AS cause_of_death,
    COUNT(d.resident_status) AS death_count
FROM 
    deaths AS d
LEFT JOIN 
    `358_cause_recode` AS c ON d.`358_cause_recode` = c.id
WHERE 
    c.id in (435, 436, 437, 438) -- Replace with relevant code
GROUP BY 
    d.month_of_death, c.code
ORDER BY 
    d.month_of_death, death_count DESC;


-- Calculating average age of mortality by condition, gender, and ethnicity
-- Mapping average age for coded age ranges
SELECT 
    c.code AS cause_of_death,
    d.sex,
    r.code AS race_description,
    h.code AS ethnicity,
    AVG(CASE 
            WHEN a.id = '01' THEN 0.02    -- 'Under 1 hour' approximated as 0.02 days (half an hour)
        WHEN a.id = '02' THEN 0.5     -- '1 - 23 hours' approximated as 0.5 days
        WHEN a.id = '03' THEN 1       -- '1 day'
        WHEN a.id = '04' THEN 2       -- '2 days'
        WHEN a.id = '05' THEN 3       -- '3 days'
        WHEN a.id = '06' THEN 4       -- '4 days'
        WHEN a.id = '07' THEN 5       -- '5 days'
        WHEN a.id = '08' THEN 6       -- '6 days'
        WHEN a.id = '09' THEN 10      -- '7 - 13 days' approximated as 10 days
        WHEN a.id = '10' THEN 17      -- '14 - 20 days' approximated as 17 days
        WHEN a.id = '11' THEN 24      -- '21 - 27 days' approximated as 24 days
        WHEN a.id = '12' THEN 30      -- '1 month'
        WHEN a.id = '13' THEN 60      -- '2 months'
        WHEN a.id = '14' THEN 90      -- '3 months'
        WHEN a.id = '15' THEN 120     -- '4 months'
        WHEN a.id = '16' THEN 150     -- '5 months'
        WHEN a.id = '17' THEN 180     -- '6 months'
        WHEN a.id = '18' THEN 210     -- '7 months'
        WHEN a.id = '19' THEN 240     -- '8 months'
        WHEN a.id = '20' THEN 270     -- '9 months'
        WHEN a.id = '21' THEN 300     -- '10 months'
        WHEN a.id = '22' THEN 330     -- '11 months'
        WHEN a.id = '23' THEN 1       -- '1 year'
        WHEN a.id = '24' THEN 2       -- '2 years'
        WHEN a.id = '25' THEN 3       -- '3 years'
        WHEN a.id = '26' THEN 4       -- '4 years'
        WHEN a.id = '27' THEN 7       -- '5 - 9 years' approximated as 7 years
        WHEN a.id = '28' THEN 12      -- '10 - 14 years' approximated as 12 years
        WHEN a.id = '29' THEN 17      -- '15 - 19 years' approximated as 17 years
        WHEN a.id = '30' THEN 22      -- '20 - 24 years' approximated as 22 years
        WHEN a.id = '31' THEN 27      -- '25 - 29 years' approximated as 27 years
        WHEN a.id = '32' THEN 32      -- '30 - 34 years' approximated as 32 years
        WHEN a.id = '33' THEN 37      -- '35 - 39 years' approximated as 37 years
        WHEN a.id = '34' THEN 42      -- '40 - 44 years' approximated as 42 years
        WHEN a.id = '35' THEN 47      -- '45 - 49 years' approximated as 47 years
        WHEN a.id = '36' THEN 52      -- '50 - 54 years' approximated as 52 years
        WHEN a.id = '37' THEN 57      -- '55 - 59 years' approximated as 57 years
        WHEN a.id = '38' THEN 62      -- '60 - 64 years' approximated as 62 years
        WHEN a.id = '39' THEN 67      -- '65 - 69 years' approximated as 67 years
        WHEN a.id = '40' THEN 72      -- '70 - 74 years' approximated as 72 years
        WHEN a.id = '41' THEN 77      -- '75 - 79 years' approximated as 77 years
        WHEN a.id = '42' THEN 82      -- '80 - 84 years' approximated as 82 years
        WHEN a.id = '43' THEN 87      -- '85 - 89 years' approximated as 87 years
        WHEN a.id = '44' THEN 92      -- '90 - 94 years' approximated as 92 years
        WHEN a.id = '45' THEN 97      -- '95 - 99 years' approximated as 97 years
        WHEN a.id = '46' THEN 102     -- '100 - 104 years' approximated as 102 years
        WHEN a.id = '47' THEN 107     -- '105 - 109 years' approximated as 107 years
        WHEN a.id = '48' THEN 112     -- '110 - 114 years' approximated as 112 years
        WHEN a.id = '49' THEN 117     -- '115 - 119 years' approximated as 117 years
        WHEN a.id = '50' THEN 122     -- '120 - 124 years' approximated as 122 years
        WHEN a.id = '51' THEN 130     -- '125 years and over' approximated as 130 years
        WHEN a.id = '52' THEN NULL    -- 'Age not stated'
        ELSE NULL
    END) AS average_age
FROM 
    deaths AS d
LEFT JOIN 
    `358_cause_recode` AS c ON d.`358_cause_recode` = c.id
LEFT JOIN 
    race AS r ON d.race = r.id
LEFT JOIN 
    hispanic_origin AS h ON d.hispanic_origin = h.id
LEFT JOIN 
    age_recode_52 AS a ON d.age_recode_52 = a.id -- Adjust this column based on your actual mapping
GROUP BY 
    c.code, d.sex, r.code, h.code
ORDER BY 
    average_age DESC;


-- Segmenting mortality by lifestyle-related vs. non-lifestyle factors
SELECT 
    CASE 
        WHEN c.id IN (454, 298, 178) THEN 'Lifestyle-Related'
        ELSE 'Non-Lifestyle Related'
    END AS lifestyle_factor,
    COUNT(d.resident_status) AS death_count
FROM 
    deaths AS d
LEFT JOIN 
    `358_cause_recode` AS c ON d.`358_cause_recode` = c.id
GROUP BY 
    lifestyle_factor
ORDER BY 
    death_count DESC;


-- Examining the impact of socio-economic factors on mortality
SELECT 
    e.code AS education_level,
    m.code AS marital_status,
    COUNT(d.resident_status) AS death_count
FROM 
    deaths AS d
LEFT JOIN 
    education_2003_revision AS e ON d.education_2003_revision = e.id
LEFT JOIN 
    marital_status AS m ON d.marital_status = m.id
GROUP BY 
    e.code, m.code
ORDER BY 
    death_count DESC;
