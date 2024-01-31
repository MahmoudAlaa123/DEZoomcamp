-- Question 3
SELECT count(lpep_pickup_datetime)
	FROM public.green_taxi_trips_hw
	WHERE date(lpep_pickup_datetime)='2019-09-18' and date(lpep_pickup_datetime)='2019-09-18';
	
-- Question 4	
SELECT date(lpep_pickup_datetime), max(trip_distance) max_trip_distance
FROM public.green_taxi_trips_hw
GROUP BY date(lpep_pickup_datetime)
ORDER BY max_trip_distance desc;

-- Question 5
SELECT "Borough",date(lpep_pickup_datetime), SUM(total_amount) as sum_total_amount 
FROM public.green_taxi_trips_hw 
LEFT JOIN public.taxi_zone_hw 
ON "PULocationID" = "LocationID"
GROUP BY "Borough",date(lpep_pickup_datetime)
HAVING "Borough" != 'Unknown' and SUM(total_amount) >= 50000 and date(lpep_pickup_datetime)='2019-09-18'
ORDER BY sum_total_amount DESC
;



-- Question 6
with PU_Astoria as(
SELECT "PULocationID","DOLocationID","Zone",tip_amount
FROM public.green_taxi_trips_hw 
LEFT JOIN public.taxi_zone_hw 
ON "PULocationID" = "LocationID"
WHERE "Zone"='Astoria' and EXTRACT(month FROM lpep_pickup_datetime)='9'
	)
SELECT "DOLocationID", taxi_zone."Zone", MAX(tip_amount) max_tip
FROM PU_Astoria
LEFT JOIN public.taxi_zone_hw taxi_zone
ON "DOLocationID" = "LocationID"
GROUP BY "DOLocationID",taxi_zone."Zone"
ORDER BY max_tip DESC
;
