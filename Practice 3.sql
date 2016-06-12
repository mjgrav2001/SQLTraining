-- 1 Find average speed per CPU

select avg(speed/cpu) as avgspeed
from configuration


-- 2 Find average speed weighted by Memory
-- See the definition of weighted average: https://en.wikipedia.org/wiki/Weighted_arithmetic_mean

select sum(speed * memory)/sum(memory) as weightedspeed
from configuration