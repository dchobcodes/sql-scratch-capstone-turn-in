Funnels with Warby Parker
Deidania Chobot
November 21, 2018

--select all columns from the survey table
SELECT *
FROM survey
LIMIT 10;

--select number of responses for each question
SELECT question, COUNT(DISTINCT user_id)
FROM survey
WHERE question IS NOT NULL
GROUP BY 1;


--select all columns from the quiz table
SELECT *
FROM quiz
LIMIT 5;


--select all columns from the home_try_on table
SELECT *
FROM home_try_on
LIMIT 5;


--select all columns from the purchase table
SELECT *
FROM purchase
LIMIT 5;


--table where each row represents a single user
SELECT DISTINCT q.user_id,
h.number_of_pairs,
h.user_id IS NOT NULL AS 'is_home_try_on',
p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'

LEFT JOIN home_try_on 'h'
ON q.user_id = h.user_id

LEFT JOIN purchase 'P'
ON p.user_id = q.user_id
LIMIT 10;


--Calculate conversion rate by aggregating accross all rows 
--Camparison of conversion rates
WITH funnels AS
(
SELECT DISTINCT q.user_id,
h.number_of_pairs,
h.user_id IS NOT NULL AS 'is_home_try_on',
p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'

LEFT JOIN home_try_on 'h'
ON q.user_id = h.user_id

LEFT JOIN purchase 'P'
ON p.user_id = q.user_id
)


SELECT 
number_of_pairs, 
COUNT(*) AS 'num_quizes',
SUM(is_home_try_on) AS 'num_tries',
SUM(is_purchase) AS 'num_purchase',

1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'percentUserQtoT',

1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 
'percentUserTtoP'

FROM funnels;


--Calculate difference between purchase rates between customers with 3 pairs vs 5
WITH funnels AS
(
SELECT DISTINCT q.user_id,
h.number_of_pairs,
h.user_id IS NOT NULL AS 'is_home_try_on',
p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'

LEFT JOIN home_try_on 'h'
ON q.user_id = h.user_id

LEFT JOIN purchase 'P'
ON p.user_id = q.user_id
)


SELECT 
number_of_pairs, 
COUNT(*) AS 'num_quizes',
SUM(is_home_try_on) AS 'num_tries',
SUM(is_purchase) AS 'num_purchase',

1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'percentUserQtoT',

1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 
'percentUserTtoP'

FROM funnels
GROUP BY 1
ORDER BY 1;


--Most common results from style quiz
SELECT style, COUNT(style)
FROM quiz
GROUP BY 1;

SELECT fit, COUNT(fit)
FROM quiz
GROUP BY 1
ORDER BY 2;

SELECT shape, COUNT(shape)
FROM quiz
GROUP BY 1
ORDER BY 2;

SELECT color, COUNT(color)
FROM quiz
GROUP BY 1
ORDER BY 2;

SELECT price, COUNT(price)
FROM purchase
GROUP BY 1
ORDER BY 1 ASC;

SELECT model_name, COUNT(model_name)
FROM purchase
GROUP BY 1
ORDER BY 2 ASC;

SELECT color, COUNT(color)
FROM purchase
GROUP BY 1
ORDER BY 2;

SELECT style, COUNT(style)
FROM purchase
GROUP BY 1
ORDER BY 2;
