-- 1 For each date in the rental table identify all rentals started at the beginning of a month,
-- end of a month or in the middle of the month.

select rentid, unitno, startdate, enddate
     , case when extract(day from startdate) = 1 then 'Beginning'
            -- we need to define last date of the month that rental starts:
            -- date_trunc(interval, dateColumn) function gets the first day of interval i.e. Month
            -- similar to integer addition/substraction time intervals can also be added/substracted.
            -- For example, in order to find the last date of the month for a rental that starts on '10-16-2015'
            -- date_trunc('month', '10-16-2015') = '10-01-2015'
            -- '10-01-2015' + interval '1 month' = '11-01-2015'
            -- '11-01-2015' - interval '1 day' = '10-30-2015'
            when extract(day from startdate) = extract(day from cast((date_trunc('month', startdate) + interval '1 month' - interval '1 day') as date)) then 'Ending'
            else 'Middle' end RentalPeriod
from rentals

-- 2 Identify length of total lease for each rental, and if the end date is not set
-- then use the current date to calculate length of lease in months.

select rentid, unitno, startdate, enddate
      -- Let's assume length of total lease is defined as total number of months between start and end dates
      -- age(date1, date2) gives number of years, months and days between two dates
     , date_part('month',age(case when enddate is null then now() else enddate end, startdate))
from rentals

