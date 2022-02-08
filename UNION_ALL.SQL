--MERGING TLC TRIPS DATASETS FROM 2017 TO 2020
SELECT
  DISTINCT *
FROM (
  SELECT
    vendor_id,
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    rate_code,
    payment_type,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    imp_surcharge,
    total_amount,
    pickup_location_id,
    dropoff_location_id
  FROM
    `cis-9440-group-project-332602.cis9440_yelllowcab_project.tlc_yellow_trips_2017`)
UNION ALL (
  SELECT
    vendor_id,
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    rate_code,
    payment_type,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    imp_surcharge,
    total_amount,
    pickup_location_id,
    dropoff_location_id
  FROM
    `cis-9440-group-project-332602.cis9440_yelllowcab_project.tlc_yellow_trips_2018`)
UNION ALL (
  SELECT
    CAST(VendorID AS STRING ) AS vendor_id,
    CAST(tpep_pickup_datetime AS DATETIME) AS pickup_datetime,
    CAST(tpep_dropoff_datetime AS DATETIME) AS dropoff_datetime,
    passenger_count,
    CAST(trip_distance AS NUMERIC ) AS trip_distance,
    CAST(RatecodeID AS STRING ) AS rate_code,
    CAST(payment_type AS STRING ) AS payment_type,
    CAST(fare_amount AS NUMERIC ) AS fare_amount,
    CAST(extra AS NUMERIC ) AS extra,
    CAST(mta_tax AS NUMERIC ) AS mta_tax,
    CAST(tip_amount AS NUMERIC ) AS tip_amount,
    CAST(tolls_amount AS NUMERIC ) AS tolls_amount,
    CAST(improvement_surcharge AS NUMERIC ) AS imp_surcharge,
    CAST(total_amount AS NUMERIC ) AS total_amount,
    CAST(PULocationID AS STRING ) AS pickup_location_id,
    CAST(DOLocationID AS STRING ) AS dropoff_location_id,
  FROM
    `cis-9440-group-project-332602.cis9440_yelllowcab_project.tlc_yellow_trips_2019`)
UNION ALL (
  SELECT
    CAST(VendorID AS STRING ) AS vendor_id,
    CAST(tpep_pickup_datetime AS DATETIME) AS pickup_datetime,
    CAST(tpep_dropoff_datetime AS DATETIME) AS dropoff_datetime,
    passenger_count,
    CAST(trip_distance AS NUMERIC ) AS trip_distance,
    CAST(RatecodeID AS STRING ) AS rate_code,
    CAST(payment_type AS STRING ) AS payment_type,
    CAST(fare_amount AS NUMERIC ) AS fare_amount,
    CAST(extra AS NUMERIC ) AS extra,
    CAST(mta_tax AS NUMERIC ) AS mta_tax,
    CAST(tip_amount AS NUMERIC ) AS tip_amount,
    CAST(tolls_amount AS NUMERIC ) AS tolls_amount,
    CAST(improvement_surcharge AS NUMERIC ) AS imp_surcharge,
    CAST(total_amount AS NUMERIC ) AS total_amount,
    CAST(PULocationID AS STRING ) AS pickup_location_id,
    CAST(DOLocationID AS STRING ) AS dropoff_location_id,
  FROM
    `cis-9440-group-project-332602.cis9440_yelllowcab_project.tlc_yellow_trips_2020`);
