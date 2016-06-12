-- 1 Identify one of the most sold configurations for each month

select y.*
from
     (
          select
               b.config
               , extract(year from a.startdate)  as year
               , extract(month from a.startdate) as month
               , count(a.rentid)                 as cnt
          from rentals as a
               join unit as b
                    on a.unitno = b.unitno
          where a.startdate >= '01-01-2016'
          group by b.config
               , extract(year from a.startdate)
               , extract(month from a.startdate)
     ) as y
join
     (
          select
               year
               , month
               , max(cnt) as maxCnt
          from
               (
                    select
                         b.config
                         , extract(year from a.startdate)  as year
                         , extract(month from a.startdate) as month
                         , count(a.rentid)                 as cnt
                    from rentals as a
                         join unit as b
                              on a.unitno = b.unitno
                    where a.startdate >= '01-01-2016'
                    group by b.config
                         , extract(year from a.startdate)
                         , extract(month from a.startdate)
               ) as x
          group by year, month
          ) as z
  on z.month = y.month
 and z.year = y.year
 and z.maxCnt = y.cnt
order by y.year, y.month


-- 2 Average time to sell a server that becomes available

select avg(extract(days from (coalesce(b.enddate, now()) - a.enddate))) as AvgTimeToSell
from rentals as a
left join rentals as b
  on a.unitno = b.unitno
 and b.startdate = (select min(l.startdate)
                    from rentals as l
                    where l.startdate > a.startdate
                      and l.unitno = a.unitno)
where a.enddate is not null