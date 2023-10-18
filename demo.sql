--Check total size of DB; should contain about 6GB for working size
SELECT pg_size_pretty(pg_database_size('tsdb'));

-- Query from trips (regular Postgres table)
SELECT
	time_bucket(INTERVAL '1 month', started_at) AS bucket,
	AVG(total_amount),
  MAX(total_amount),
  MIN(total_amount)
FROM trips
WHERE started_at >= '2022-01-01'
	AND started_at <  '2023-01-01'
  AND total_amount > 0
GROUP BY bucket;

-- Query from trips_hyper (Timescale table)
SELECT
	time_bucket(INTERVAL '1 month', started_at) AS bucket,
	AVG(total_amount),
  MAX(total_amount),
  MIN(total_amount)
FROM trips_hyper
WHERE started_at >= '2022-01-01'
	AND started_at <  '2023-01-01'
  AND total_amount > 0
GROUP BY bucket;

-- Query from total_summary_daily (Timescale Continuous Aggregate)
SELECT
	time_bucket(INTERVAL '1 month', bucket) AS month,
	AVG(avg),
  MAX(max),
  MIN(min)
FROM total_summary_daily
WHERE bucket >= '2022-01-01'
	AND bucket <  '2023-01-01'
GROUP BY month;
