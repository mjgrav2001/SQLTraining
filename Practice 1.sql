

-- Practice 1 Answers:
-- 1 - 5th sale of the January 2015

select rentid, unitno, startdate, enddate
from rentals
where extract(YEAR from startdate) = 2015
  and extract(month from startdate) = 1
order by startdate
limit 1 offset 4 --skip first 4 records and get the 5th one only


-- 2 - Distinct unit types sold less than $100

select distinct config
from price
where rent < 100

-- 3 - Top three fastest configurations

select *
from configuration
order by speed desc -- we can specificy how to order by using desc or asc notation for descending or ascending sorting
limit 3

-- 4 - Cost of third most expensive unit in ‘M’ Type configurations for January 2016

select *
from price
where substring(config, 1, 1) = 'M'
  and extract(YEAR from startdate) = 2016
  and extract(month from startdate) = 1
order by rent desc
limit 1 offset 2