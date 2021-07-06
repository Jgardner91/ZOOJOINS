-- 1 show matchid and player for all goals scored by germany 
select matchid, player 
from goal 
where teamid == 'GER';

--2. Show id , stadium , team1, team2 for just game 1012
select id, stadium , team1,team2
from game 
where id == 1012;

--3. show the player , teamid,stadium and mdate for every german goal 
select goal.player, goal.teamid, game.stadium, game.mdate
from game join goal on (id=matchid)
where teamid = 'GER';

--4. show team1 , team2 and player for every goal scored by a player called 'Mario'
select team1,team2, player
from game join goal on (id=matchid)
where player like 'Mario%';

--5. show player, teamid, coach , gtime for all goals scored in the first 10mins 
select player, teamid, coach,gtime 
from goal join eteam on id=teamid
where gtime <= 10; 

--6 list the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach 
select mdate, teamname
from game join eteam on eteam.id =team1
where coach == 'Fernando Santos';

--7 list the player for every goal scored in a game where the stadium was 'National Stadium'

select player 
from game join goal on id=matchid
where stadium = 'National Stadium, Warsaw';

-- More difficult questions 

-- 8. Show the name of all players who scored a goal against germany 
 -- use distinct(player) if you dont want to list players who scored in the game twice 

select distinct(player)
from game join goal on id=matchid
where (team1 = 'GER' or team2 = 'GER' ) and teamid != 'GER';

-- 9. show teamname and the total number of goals scored
-- if two tables share a column name make sure you specifiy which table youd like to join on with table_name.column_name

select teamname,count(teamname) as 'GS'
from goal join eteam on teamid = eteam.id
group by teamname; 

-- 10 Show the stadium and the number of goals scored in each stadium 
select stadium , count(stadium) as 'GPS'
from game join goal on id=matchid 
group by stadium; 

--11 for every match INVOLVING 'POL' show the matchid , date and the number of goals scored 
select matchid, mdate, count(matchid) as 'GIP'
from game join goal on matchid = id 
where team1 == 'POL' or  team2 == 'POL'
group by matchid;

--12 For ecery match where 'GER' scored, show matchid , match date and the number of goals scored by 'GER'
select matchid, mdate, count(matchid) as 'GGS'
from game join goal on matchid = id
where teamid == 'GER'
group by matchid;

--13 List every match with the goals scored by each team as shown. This  will use 'CASE WHEN'

select mdate, team1,

sum(CASE
	when teamid=team1 then 1 
	else 0 end ) as score1,
team2,
sum(case when teamid=team2 then 1 
		else 0 end)  as score2

from game join goal on matchid = id
group by matchid;