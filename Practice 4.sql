-- 1  Calculate number of new rentals per month

select extract(year from startdate) as  year
     , extract(month from startdate) as month
     , count(*)
from rentals
group by extract(year from startdate)
       , extract(month from startdate)
order by extract(year from startdate)
       , extract(month from startdate);


-- 2  Calculate average list price per month

select extract(year from startdate) as  year
     , extract(month from startdate) as month
     , avg(rent)
from price
group by extract(year from startdate)
       , extract(month from startdate)
order by extract(year from startdate)
       , extract(month from startdate);


-- 3 Calculate average rental length

-- Option 1: Calculate a number by extracting parts

select avg(   (extract(year from coalesce(enddate, now())) - extract(year from startdate))*12 -- Difference between years * 12
             + extract(month from coalesce(enddate,now())) - extract(month from startdate) -- Difference between months
            -- If startdate is '2015-04-30' and enddate is '2015-09-01', one full month is not completed.
            -- This is because startdate day part ( 30 ) is later than the enddate day part ( 1 )
            -- So substract 1 if this condition is true from the number of months
             + case when extract(day from coalesce(enddate,now())) < extract(day from startdate ) then -1
                    else 0 end
          )
from rentals;

-- Option 2: age function finds the difference between two dates in interval format
select avg(date_part('month', age(coalesce(enddate, now()), startdate)) + date_part('year', age(coalesce(enddate, now()), startdate))*12 )
from rentals;