-- Create a new team using the players who have larger salaries than their captain,
-- and find the total earning of the new team you created.
-- Please create and populate tables using the script below

select avg(a.Salary)
from players as a
join players as b
  on a.captainid = b.playerid
 and a.salary > b.salary;


-- Script for creating and populating tables
create table Players (
	PlayerID int not null,
	NBATeamID int not null,
	CaptainID int null,
	Salary int not null,
	Name varchar(100) not null,
	Primary key (PlayerID),
	constraint m_captain
		foreign key (CaptainID)
		references Players (PlayerID)
);

create table Teams (
	NBATeamID int not null,
	Name varchar(50)
);

INSERT INTO Players
(PlayerId, NBATeamID, CaptainID, Salary, Name)
VALUES (1, 1, 2, 150, 'A'), (2, 1, 2, 100, 'B'),
(3, 1, 2, 124, 'C'), (4, 1, 2, 90, 'D'),
(5, 1, 2, 85, 'E'), (6, 2, 8, 123, 'F'),
(7, 2, 8, 250, 'G'), (8, 2, 8, 150, 'H'),
(9, 2, 8, 175, 'I'), (10, 2, 8, 75, 'J')
;

INSERT INTO Teams
(NBATeamId, Name)
VALUES (1, 'Atlanta Hawks'), (2, 'Miami Heat')
;



