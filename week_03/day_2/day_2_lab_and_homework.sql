-- MVP
-- Q1
-- Get a table of all employees details, together with their 
-- local_account_no and local_sort_code, if they have them.

SELECT
	e.*,
	p.local_account_no,
	p.local_sort_code
FROM employees AS e
	LEFT JOIN
	pay_details as p
	ON e.id = p.id;

-- Q2
-- Amend your query from question 1 above 
-- to also return the name of the team that each employee belongs to.

SELECT
	e.*,
	p.local_account_no,
	p.local_sort_code,
	t.name
FROM (employees AS e
	LEFT JOIN
	pay_details AS p
	ON e.id = p.id)
	LEFT JOIN
	teams AS t
	ON e.team_id = t.id;

-- Q3
-- Find the first name, last name and team name of employees who are members of teams
-- for which the charge cost is greater than 80. Order the employees alphabetically by last name.

SELECT
	e.first_name,
	e.last_name,
	t.name,
	t.charge_cost
FROM employees AS e
	LEFT JOIN
	teams AS t
	ON e.team_id = t.id
WHERE CAST(t.charge_cost AS int) > 80
ORDER BY e.last_name;


-- Q4 
-- Breakdown the number of employees in each of the teams, 
--including any teams without members.
-- Order the table by increasing size of team.

join employees to teams
count number of people grouped by team including empty teams
order by size of team ASC

SELECT
	t.name,
	COUNT(e.id)
FROM teams AS t LEFT JOIN employees AS e
	ON t.id = e.team_id
GROUP BY t.id
ORDER BY COUNT(e.id) ASC NULLS LAST;


-- Q5
--The effective_salary of an employee is defined as their fte_hours multiplied by their salary. 
--Get a table for each employee showing their id, first_name, last_name, fte_hours, salary and effective_salary, 
--along with a running total of effective_salary with employees placed in ascending order of effective_salary.
 
SELECT
	id,
	first_name,
	last_name,
	fte_hours,
	salary,
	fte_hours * salary AS effective_salary
FROM employees;


-- Q6
-- The total_day_charge of a team is defined as the charge_cost of the team 
--multiplied by the number of employees in the team. Calculate the total_day_charge for each team.

SELECT
	t.name,
	COUNT(e.id) AS team_size,
	CAST(t.charge_cost AS int) * COUNT(e.id) AS total_day_charge
FROM
	employees AS e
	INNER JOIN
	teams AS t
	ON e.team_id = t.id
GROUP BY t.id
ORDER BY team_size;


-- Q7
-- How would you amend your query from question 6 above to show only those teams 
-- with a total_day_charge greater than 5000?

SELECT
	t.name,
	COUNT(e.id) AS team_size,
	CAST(t.charge_cost AS int) * COUNT(e.id) AS total_day_charge
FROM
	employees AS e
	INNER JOIN
	teams AS t
	ON e.team_id = t.id
GROUP BY t.id
HAVING CAST(t.charge_cost AS int) * COUNT(e.id) > 5000
ORDER BY total_day_charge;

-- EXT
-- Q1
-- How many of the employees serve on one or more committees?

SELECT
	COUNT(DISTINCT(e.id))
FROM 
	employees AS e	
	INNER JOIN
	employees_committees AS ec
	ON e.id = ec.employee_id

--Q2
-- How many of the employees do not serve on a committee?
SELECT
	COUNT(DISTINCT(e.id))
FROM 
	employees AS e	
	LEFT JOIN
	employees_committees AS ec
	ON e.id = ec.employee_id
WHERE ec.committee_id IS NULL



-- Q3
-- Get the full employee details (including committee name) of any committee members based in China.

SELECT
	-- all employee details
	e.*,
	-- plus committee name
	c.name AS committee_name
-- join committees to join table then employees to the result of this. 
-- This ordering and using inner join ensures we only return employees who are part of a committee.
FROM committees AS c
	INNER JOIN
	employees_committees AS ec
	ON  c.id = ec.committee_id
	INNER JOIN
	employees as e
	ON ec.employee_id = e.id
-- filter for employees in China
WHERE country = 'China'
	

--Q4 [Tough!] 
-- Group committee members into the teams in which they work, 
-- counting the number of committee members in each team (including teams with no committee members). 
-- Order the list by the number of committee members, highest first.


-- output a count of team name and number of commmittee members in that team
SELECT
	e.team_id,
-- COUNT()
-- join employees, committees and employees_committees
-- when joining, ensure we retain teams who have no committee members i.e. use LEFT JOIN
FROM
	employees AS e
	LEFT JOIN
	employees_committees AS ec
		ON e.id = ec.employee_id
	LEFT JOIN
	committees AS c
		ON ec.committee_id = c.id
-- group by teams
GROUP BY e.team_id
-- order by the number of committee members, highest first
-- ORDER BY COUNT DESC NULLS LAST
