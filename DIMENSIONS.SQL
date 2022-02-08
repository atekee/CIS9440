--CREATING DIM COMPLAINTS
WITH
  Dim_Complaint_Desc AS (
  SELECT
    complaint_type,
    descriptor,
    incident_zip,
    incident_address,
    street_name,
    city,
    borough
  FROM
    `cis-9440-group-project-332602.cis9440_311.311_service_request` )
SELECT
  ROW_NUMBER() OVER() AS complaint_id,
  *
FROM
  Dim_Complaint_Desc
ORDER BY
  complaint_id ASC;


--CREATING DIM LOCATION
WITH
  Dim_location AS (
  SELECT
    location,
    street_name,
    incident_zip,
    borough,
    city,
    taxi_pick_up_location,
    longitude,
    latitude
  FROM
    `cis-9440-group-project-332602.cis9440_311.311_service_request` )
SELECT
  ROW_NUMBER() OVER() AS location_id,
  *
FROM
  Dim_Location
ORDER BY
  location_id ASC;


--CREATING DIM PAYMENT
WITH	
  Dim_Payment AS (
  SELECT
    rate_code,
    payment_type,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    imp_surcharge,
    total_amount
  FROM
    `cis-9440-group-project-332602.cis9440_yelllowcab_project.tlc_yellow_trips` )
SELECT
  ROW_NUMBER() OVER() AS payment_id,
  *
FROM
  Dim_Payment
ORDER BY
  payment_id ASC;


--CREATING DIM TRIP
WITH
  Dim_Trip AS (
  SELECT
    vendor_id,
    passenger_count,
    pickup_location_id,
    dropoff_location_id,
    trip_distance,
    rate_code
  FROM
    `cis-9440-group-project-332602.cis9440_yelllowcab_project.tlc_yellow_trips` )
SELECT
  ROW_NUMBER() OVER() AS trip_id,
  *
FROM
  Dim_Trip
ORDER BY
  trip_id ASC;



--CREATING DATE DIM FOR TLC YELLOW TRIPS
WITH
  Dim_Date2 AS (
  SELECT
    EXTRACT(year
    FROM
      pickup_datetime) AS year,
    EXTRACT(month
    FROM
      pickup_datetime) AS month,
    EXTRACT(week
    FROM
      pickup_datetime) AS week,
    EXTRACT(day
    FROM
      pickup_datetime) AS day,
    EXTRACT(DAYOFWEEK
    FROM
      pickup_datetime) AS day_of_week,
    EXTRACT(HOUR
    FROM
      pickup_datetime) AS hr,
    EXTRACT(MINUTE
    FROM
      pickup_datetime) AS mn
  FROM
    `cis-9440-group-project-332602.cis9440_yelllowcab_project.tlc_yellow_trips` )
SELECT
  ROW_NUMBER() OVER() AS date_id,
  *
FROM
  Dim_Date2
ORDER BY
  date_id ASC;



--CREATING DATE DIM FOR 311 SERVICE
WITH
  Dim_Date1 AS (
  SELECT
    EXTRACT(year
    FROM
      created_date) AS year,
    EXTRACT(month
    FROM
      created_date) AS month,
    EXTRACT(week
    FROM
      created_date) AS week,
    EXTRACT(day
    FROM
      created_date) AS day,
    EXTRACT(DAYOFWEEK
    FROM
      created_date) AS day_of_week,
  FROM
    `cis-9440-group-project-332602.cis9440_311.311_service_request`)
SELECT
  ROW_NUMBER() OVER() AS date_id,
  *
FROM
  Dim_Date1
ORDER BY
  date_id ASC;
