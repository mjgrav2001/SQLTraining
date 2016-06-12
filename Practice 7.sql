
-- 1 Find the configuration that has a Memory closest to the average Memory.

select a.name, abs(a.memory- c.avgmemory)  as diffFromAverage
from configuration as a
join (select avg(b.memory) as avgmemory
      from configuration as b
      ) as c
  on 1=1
order by abs(a.memory- c.avgmemory)
limit 1


-- 2 Identify the configurations that sold more than 10 units in first three month of 2016

select config, count(distinct b.rentid)
from unit as a
join rentals as b
  on a.unitno = b.unitno
where b.startdate >= '01-01-2016'
  and b.startdate <= '03-31-2016'
group by config
having count(distinct b.rentid) > 10