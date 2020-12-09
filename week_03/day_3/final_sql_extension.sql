-- EXT --

--Q1
/* [Tough] Get a list of the id, first_name, last_name, salary and fte_hours of employees in the largest department.
 * Add two extra columns showing the ratio of each employee’s salary to that department’s average salary, 
 * and each employee’s fte_hours to that department’s average fte_hours.
 */

--Step 1. Find largest dept
-- A: legal

SELECT
	department,
	COUNT(id) AS members
FROM employees
GROUP BY department
ORDER BY COUNT(id) DESC NULLS LAST
LIMIT 1;

--Step 2. Build a table with only employees from largest dept

-- Find largest dept and create a CTE containing only that department
WITH ds(department, members) AS
	(SELECT department, COUNT(id)
	FROM employees
	GROUP BY department
	ORDER BY COUNT(id) DESC NULLS LAST
	LIMIT 1)
-- List id, first_name, last_name, salary and fte_hours of employees
SELECT
	first_name,
	last_name,
	salary,
	fte_hours
-- Inner join my employees table with my table containing only the largest dept 
-- i.e. return all employees from my original table who work in the largest department
FROM employees AS e INNER JOIN ds
	ON e.department = ds.department
-- uneccessary bootstrap step to check that I only have those 
--where the department has matched with the department in my CTE
WHERE ds.members IS NOT NULL;


-- Step 3.
-- Add columns comparing average salary and avg FTE with each employees salary and FTE

-- Create a CTE containing only th largest department along with is average salary and fte_hours
WITH ds(department, members, avg_salary, avg_fte) AS
	(SELECT department, COUNT(id), AVG(salary), AVG(fte_hours)
	FROM employees
	GROUP BY department
	ORDER BY COUNT(id) DESC NULLS LAST
	LIMIT 1)
-- List id, first_name, last_name, salary and fte_hours of employees
-- Select column dividing each salary by avg salary of biggest team 
-- Select column diving each fte_hours by avg of fte_hours
SELECT
	e.first_name,
	e.last_name,
	e.salary,
	e.fte_hours,
	e.salary / ds.avg_salary AS salary_over_dept_avg,
	e.fte_hours / ds.avg_fte AS hours_over_dept_avg
-- Inner join my employees table with my table containing only the largest dept 
-- i.e. return all employees from my original table who work in the largest department
FROM employees AS e INNER JOIN ds
	ON e.department = ds.department;


--Q2
/* Have a look again at your table for MVP question 6. 
 * It will likely contain a blank cell for the row relating to employees with ‘unknown’ pension enrollment status. 
 * This is ambiguous: it would be better if this cell contained ‘unknown’ or something similar. 
 * Can you find a way to do this, perhaps using a combination of COALESCE() and CAST(), or a CASE statement?
 */

SELECT CAST(pension_enrol AS VARCHAR), COUNT(id)
FROM employees
GROUP BY pension_enrol;

SELECT (CASE
	WHEN pension_enrol IS TRUE THEN 'Enrolled'
	WHEN pension_enrol IS FALSE THEN 'Not Enrolled'
	WHEN pension_enrol IS NULL THEN 'Enrolment Unknown'
	END) AS pension_enrolment,
	COUNT(id)
FROM employees
GROUP BY pension_enrol
ORDER BY pension_enrol;

--Q3
/* Find the first name, last name, email address and start date of all the employees 
 * who are members of the ‘Equality and Diversity’ committee. 
 * Order the member employees by their length of service in the company, longest first.
 */

--Select first name, last name, email address and start date
SELECT
	e.first_name,
	e.last_name,
	e.email,
	e.start_date
-- Join employees to committees (via employees_committees) retaining only employees who are in a committee
FROM
	employees AS e INNER JOIN employees_committees AS ec
		ON e.id = ec.employee_id
	INNER JOIN committees AS c
		ON ec.committee_id = c.id
-- Filter to only look at those employees on committee 'Equality and Diversity
WHERE c.name = 'Equality and Diversity'
-- Order the member employees by their length of service in the company, longest first.
ORDER BY start_date ASC NULLS LAST;

--Q4
/* [Tough!] Use a CASE() operator to group employees who are members of committees into salary_class of 
 * low' (salary < 40000) or 'high' (salary >= 40000). A NULL salary should lead to 'none' in salary_class. 
 * Count the number of committee members in each salary_class.
 */

-- Step 1.
-- Build a table which assigns salary class to each employee, groups by salary class 
-- and counts number of employees in that class

SELECT
	(CASE
	WHEN salary < 40000 THEN 'high'
	WHEN salary >= 40000 THEN 'low'
	WHEN salary IS NULL THEN 'none'
	END) AS salary_class,
	COUNT(id),
FROM employees
GROUP BY salary_class;

-- Step 2.
-- Count the number of committee members in each salary class

SELECT
	(CASE
	WHEN salary < 40000 THEN 'high'
	WHEN salary >= 40000 THEN 'low'
	WHEN salary IS NULL THEN 'none'
	END) AS salary_class,
	COUNT(e.id)
-- Choosing inner joins so I only end up with employees who are committee members
FROM employees AS e INNER JOIN employees_committees AS ec
		ON e.id = ec.employee_id
	INNER JOIN committees AS c
		ON ec.committee_id = c.id
GROUP BY salary_class;