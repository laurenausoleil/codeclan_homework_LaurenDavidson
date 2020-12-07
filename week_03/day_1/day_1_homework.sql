-- Find all the employees who work in the ‘Human Resources’ department.
SELECT *
FROM employees
WHERE department = 'Human Resources';

-- Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department.
SELECT
	first_name,
	last_name,
	country
FROM employees
WHERE department = 'Legal';

-- Count the number of employees based in Portugal.
SELECT
	count(*) AS employees_in_portugal
FROM employees
WHERE country = 'Portugal';

-- Count the number of employees based in either Portugal or Spain.
SELECT
	count(*) AS employees_in_spain_and_portugal
FROM employees
WHERE country IN ('Portugal', 'Spain');

-- Count the number of pay_details records lacking a local_account_no.
SELECT
	COUNT(*)
FROM pay_details
WHERE local_account_no IS NULL;

-- Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last).
SELECT
	last_name,
	first_name
FROM employees
ORDER BY last_name NULLS LAST;

-- How many employees have a first_name beginning with ‘F’?
SELECT
	COUNT(*)
FROM employees
WHERE first_name LIKE 'F%';

--Count the number of pension enrolled employees not based in either France or Germany.
SELECT
	COUNT(*)
FROM employees
WHERE COUNTRY NOT IN ('France', 'Germany') AND pension_enrol = TRUE;


-- Obtain a count by department of the employees who started work with the corporation in 2003.
SELECT
	department,
	COUNT(*)
FROM employees
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department;

/* Obtain a table showing department, fte_hours 
 * and the number of employees in each department who work each fte_hours pattern. 
 * Order the table alphabetically by department, and then in ascending order of fte_hours.
 */
SELECT 
	department,
	fte_hours,
	COUNT(*)
FROM employees
GROUP BY
	department,
	fte_hours
ORDER BY
	department NULLS LAST,
	fte_hours NULLS LAST;

/* Obtain a table showing any departments in which there are two or more employees lacking a stored first name. 
 * Order the table in descending order of the number of employees lacking a first name, 
 * and then in alphabetical order by department.
 */

SELECT
	department,
	COUNT(*) AS num_missing_first_names
FROM employees
WHERE first_name IS NULL
GROUP BY department
HAVING COUNT(*) > 2
ORDER BY department;

[Tough!] Find the proportion of employees in each department who are grade 1.

SELECT
	COUNT(*)
FROM employees
WHERE grade = 1
GROUP BY department;

SELECT
	COUNT(*) AS num_employees_in_department
FROM employees
GROUP BY department;

	
SELECT
	department,
	(SELECT	COUNT(*) FROM employees) 
	/ 
	(SELECT	COUNT(*) FROM employees WHERE grade = 1)
	* 100 
	AS proportion_grade_1
FROM employees
GROUP BY department;

SELECT
	department,
	num_employees_in_dept / num_grade_1_employees_in_dept * 100 AS proportion_grade_1
FROM employees;
	
	
