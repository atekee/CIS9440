--CREATING TABLES FOR KPI DASHBOARD

--1)PASSENGER COMPLAINTS BY LOCATION
WITH
  tablea AS (
  SELECT
    descriptor,
    longitude,
    latitude,
    CONCAT(latitude,',',Longitude) AS longlat,
    year,
    month
  FROM
    `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Location` loc
  JOIN
    `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Complaint_Desc` comp
  ON
    (loc.location_id = comp.complaint_id)
  FULL JOIN
    `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Date1` dimdate1
  ON
    (dimdate1.date_id = loc.location_id))
SELECT
  *
FROM
  tablea
WHERE
  year >2016
  AND year <2021



--2)PASSENGER COMPLAINTS VS TLC TRIPS BY MONTH
WITH
  table_a AS (
  SELECT
    COUNT(*) AS complaints,
    month AS dm1,
    year AS dy1
  FROM
    `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Date1` d1
  JOIN
    `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Complaint_Desc` c1
  ON
    d1.date_id = c1.complaint_id
  WHERE
    year BETWEEN 2017
    AND 2020
  GROUP BY
    year,
    month),
  table_b AS (
  SELECT
    COUNT(*) AS trips,
    month AS dm2,
    year AS dy2
  FROM
    `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Date2` d2
  JOIN
    `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Trip` t1
  ON
    d2.date_id = t1.trip_id
  WHERE
    year BETWEEN 2017
    AND 2020
  GROUP BY
    year,
    month)
SELECT
  IFNULL(SUM(complaints),
    0) AS complaints,
  SUM(trips) AS trips,
  dy2 AS year,
  dm2 AS month
FROM
  table_a
RIGHT JOIN
  table_b
ON
  table_a.dm1=table_b.dm2
  AND table_a.dy1=table_b.dy2
GROUP BY
  dy2,
  dm2
ORDER BY
  dy2;



--3,4,5)AVG TRIP DISTANCE, FARE AND TIP AMOUNT BY BOROUGH
WITH
  loc AS (
  SELECT
    year,
    trip_id,
    trip_distance,
    pickup_location_id,
    Borough AS borough
  FROM
    `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Trip` dimtrip
  FULL JOIN
    `cis-9440-group-project-332602.cis9440_dim_fact_tables.taxi_zone_lookup` taxizonelookup
  ON
    (dimtrip.pickup_location_id = CAST(taxizonelookup.LocationID AS STRING))
  FULL JOIN
    `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Date2` dimdate2
  ON
    dimdate2.date_id = dimtrip.trip_id )
SELECT
  year,
  borough,
  ROUND(AVG(dimpay.fare_amount),2) avg_fare_amount,
  ROUND(AVG(dimpay.tip_amount),2) avg_tip_amount,
  ROUND(AVG(loc.trip_distance),2) avg_trip_distance,
FROM
  loc
INNER JOIN
  `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Payment` dimpay
ON
  (dimpay.payment_id = loc.trip_id)
WHERE
  fare_amount > 0
  AND tip_amount >= 0
  AND trip_distance > 0
  AND year >2016
  AND year <2021
GROUP BY
  year,
  borough
ORDER BY
  Year



--6.1) DAY OF WEEK BY NUMBER OF COMPLAINTS
SELECT
  COUNT(*) AS complaints,
  d1.day_of_week,
  d1.year
FROM
  `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Date1` d1
JOIN
  `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Complaint_Desc` c1
ON
  d1.date_id = c1.complaint_id
WHERE
  d1.year BETWEEN 2017
  AND 2020
GROUP BY
  d1.day_of_week,
  d1.year
ORDER BY
  complaints DESC



--6.2) DAY OF WEEK BY NUMBER OF TRIPS
SELECT
  COUNT(*) AS trips,
  d2.day_of_week,
  d2.year
FROM
  `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Date2` d2
JOIN
  `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Trip` t1
ON
  d2.date_id = t1.trip_id
WHERE
  d2.year BETWEEN 2017
  AND 2020
GROUP BY
  d2.day_of_week,
  d2.year
ORDER BY
  trips DESC



--7) NUMBER OF TRIPS BY PASSENGER GROUP SIZE
SELECT
  COUNT(*) AS number_of_trips,
  passenger_count,
  year
FROM
  `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Trip` t1
JOIN
  `cis-9440-group-project-332602.cis9440_dim_fact_tables.Dim_Date2` d2
ON
  t1.trip_id = d2.date_id
WHERE
  year > 2016
  AND year < 2021
  AND passenger_count >0
  AND passenger_count < 8
GROUP BY
  passenger_count,
  year
