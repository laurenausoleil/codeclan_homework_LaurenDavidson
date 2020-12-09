--MVP--

-- Q1
/* Are there any pay_details records lacking both a local_account_no and iban number? 
 * A: None found
 */
SELECT
	count(e.id)
FROM employees AS e LEFT JOIN pay_details AS p
	ON e.id = p.id
WHERE p.local_account_no IS NULL
	AND iban IS NULL;

-- Q2
/* Get a table of employees first_name, last_name and country, ordered alphabetically first by country 
 * and then by last_name (put any NULLs last).
 */
SELECT first_name, last_name, country
FROM employees
ORDER BY country ASC NULLS LAST, last_name ASC NULLS LAST;

-- Q3
/* Find the details of the top ten highest paid employees in the corporation. */

SELECT *
FROM employees
ORDER BY salary DESC NULLS LAST
LIMIT 10;

--Q4
/* Find the first_name, last_name and salary of the lowest paid employee in Hungary. 
 * A: Eveline Canton earns 20,19
 */
SELECT first_name, last_name, salary
FROM employees
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST
LIMIT 1;

-- Q5
/* Find all the details of any employees with a ‘yahoo’ email address? */

SELECT *
FROM employees
WHERE email LIKE '%@yahoo%';

-- Q6
/* Provide a breakdown of the numbers of employees enrolled, not enrolled, and with unknown enrollment status 
 * in the corporation pension scheme.
 */
SELECT CAST(pension_enrol AS VARCHAR), COUNT(id)
FROM employees
GROUP BY pension_enrol;

-- using case when to edit the names of the values in the pension_enrol column.
SELECT (CASE
	WHEN pension_enrol IS TRUE THEN 'Enrolled'
	WHEN pension_enrol IS FALSE THEN 'Not Enrolled'
	WHEN pension_enrol IS NULL THEN 'Enrolment Unknown'
	END) AS pension_enrolment,
	COUNT(id)
FROM employees
GROUP BY pension_enrol
ORDER BY pension_enrol;

-- Q7
/* What is the maximum salary among those employees in the ‘Engineering’ department 
 * who work 1.0 full-time equivalent hours (fte_hours)?
 * A: 83,370
 */

SELECT
	max(salary)
FROM employees
WHERE
	department = 'Engineering'
	AND fte_hours = 1.0;

-- Q8
/* Get a table of country, number of employees in that country, 
 * and the average salary of employees in that country for any countries in which more than 30 employees are based. 
 * Order the table by average salary descending.
 */

SELECT
	country,
	COUNT(id) AS num_employees,
	AVG(salary) AS country_avg_salary
FROM employees
GROUP BY country
HAVING COUNT(id) > 30
ORDER BY country_avg_salary DESC NULLS LAST;

-- Q9
/* Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), 
 * salary, and a new column effective_yearly_salary which should contain fte_hours multiplied by salary.
 */

SELECT
	first_name, last_name, fte_hours, salary,
	fte_hours * salary AS effective_yearly_salary
FROM employees;

-- Q10
/* Find the first name and last name of all employees who lack a local_tax_code. */

SELECT e.first_name, e.last_name
FROM employees AS e LEFT JOIN pay_details AS p
	ON e.id = p.id
WHERE p.local_tax_code IS NULL;

-- Q11
/* The expected_profit of an employee is defined as (48 * 35 * charge_cost - salary) * fte_hours, 
 * where charge_cost depends upon the team to which the employee belongs. 
 * Get a table showing expected_profit for each employee.
 */

-- select column expected_profit equal to (48 * 35 * t.charge_cost - e.salary) * e.fte_hours
SELECT
	e.first_name,
	e.last_name,
	t.name AS team_name,
	(48 * 35 * CAST(t.charge_cost AS int) - e.salary) * e.fte_hours AS expected_profit
-- join t.charge_cost to employees, keeping all employee details
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id;

-- Q12
/* [Bit Tougher] Return a table of those employee first_names shared by more than one employee, 
 * together with a count of the number of times each first_name occurs. 
 * Omit employees without a stored first_name from the table. 
 * Order the table descending by count, and then alphabetically by first_name.
 */

-- Select first_names and a count of unique ids appearing in that name
SELECT
	first_name,
	COUNT(id) AS number_of_employees_with_name
FROM employees
-- Remove NULL names
WHERE first_name IS NOT NULL
-- Group by first names
GROUP BY first_name
-- Filter to only names which appear more than once
HAVING COUNT(id) > 1
ORDER BY COUNT(id) DESC NULLS LAST, first_name ASC NULLS LAST;