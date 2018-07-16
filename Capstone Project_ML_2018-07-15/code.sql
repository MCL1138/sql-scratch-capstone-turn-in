-- Question 1    
SELECT COUNT(DISTINCT utm_campaign) AS 'Number of distinct campaigns'
FROM page_visits;

SELECT COUNT(DISTINCT utm_source) AS 'Number of distinct sources'
FROM page_visits;

SELECT DISTINCT utm_campaign AS 'Campaign',
								utm_source AS 'Source'
FROM page_visits;

-- Question 2
SELECT DISTINCT page_name AS 'Pages on the CoolTShirts website'
FROM page_visits;

-- Question 3
WITH first_touch AS (
    SELECT user_id,
       		 MIN(timestamp) AS 'first_touch_at'
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (
		SELECT ft.user_id,
					 ft.first_touch_at,
     			 pv.utm_campaign
		FROM first_touch AS 'ft'
		JOIN page_visits AS 'pv'
    		ON ft.user_id = pv.user_id
    		AND ft.first_touch_at = pv.timestamp)
SELECT ft_attr.utm_campaign AS 'Campaign',
			 COUNT(*) AS 'Count of first touches'
FROM ft_attr
GROUP BY 1
ORDER BY 2 DESC;

-- Question 4
WITH last_touch AS (
    SELECT user_id,
       MAX(timestamp) AS 'last_touch_at'
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (
		SELECT lt.user_id,
       		 lt.last_touch_at,
       		 pv.utm_campaign,
       		 pv.page_name
		FROM last_touch AS 'lt'
		JOIN page_visits AS 'pv'
   			ON lt.user_id = pv.user_id
    		AND lt.last_touch_at = pv.timestamp)
SELECT lt_attr.utm_campaign AS 'Campaign',
       COUNT(*) AS 'Count of last touches'
FROM lt_attr
GROUP BY 1
ORDER BY 2 DESC;

-- Question 5
SELECT COUNT(DISTINCT user_id) AS 'Visitors making a purchase'
FROM page_visits
WHERE page_name = '4 - purchase';

-- Question 6
WITH last_touch AS (
    SELECT user_id,
       MAX(timestamp) AS 'last_touch_at'
    FROM page_visits
  	WHERE page_name = '4 - purchase'
    GROUP BY user_id),
lt_attr AS (
		SELECT lt.user_id,
       		 lt.last_touch_at,
       		 pv.utm_campaign,
       		 pv.page_name
		FROM last_touch AS 'lt'
		JOIN page_visits AS 'pv'
   			ON lt.user_id = pv.user_id
    		AND lt.last_touch_at = pv.timestamp)
SELECT lt_attr.utm_campaign AS 'Campaign',
       COUNT(*) AS 'Count of last touches on the purchase page'
FROM lt_attr
GROUP BY 1
ORDER BY 2 DESC;