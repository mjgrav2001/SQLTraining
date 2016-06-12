
-- Insert a new team.
-- Update the team of the players who have larger salaries than their captain with the new team.
-- Update their captain as the 3rd most earning player for the new team you created.
-- Please create and populate tables using the script in Practice 6

insert into teams (nbateamid, name)
values (3, 'OKC Thunder' );


update players as a
set nbateamid = 3
from players as b
where a.captainid = b.playerid
 and a.salary > b.salary;

update players as a
set captainid = (select b.playerid
                 from players as b
                 where b.nbateamid = 3
                 order by b.salary desc
                 limit 1 offset 2
                  )
where a.nbateamid = 3