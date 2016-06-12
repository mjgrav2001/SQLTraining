

-- 1 Calculate total number of available units at the beginning of  January 2016
-- If there are no rentals occupying a unit, rentid column will have null value

select count(*)
from unit as a
left join rentals as b
on a.unitno = b.unitno
and b.startdate <= '01-01-2016' -- started before '01-01-2016
and coalesce(b.enddate, now()) > '01-01-2016' -- ended after '01-01-2016
where b.rentid is null;


-- 2 Calculate average listed rental price that new rentals paid after September 2015

select avg(c.rent)
from rentals as a
join unit as b
  on a.unitno = b.unitno
join price as c
  on b.config = c.config
 -- Next two conditions find the active rent on the day of rental start
 and a.startdate >= c.startdate
 and a.startdate <= c.enddate
where a.startdate >= '09-01-2015';