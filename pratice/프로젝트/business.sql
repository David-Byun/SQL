/* Display the average salary for each job title in the company. */

SELECT j.job_title, AVG(e.salary)
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title;

/* Show a list of employees who earn more than the average salary in their department. */
SELECT e.employee_id, e.first_name, e.last_name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);

/* Show a list of employees who earn more than the average salary in their job title. */
SELECT e.employee_id, e.first_name, e.last_name, e.salary, j.job_title
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE job_id = e.job_id);

/* Display the minimum and maximum salaries for each department. */
SELECT d.department_name, MIN(e.salary), MAX(e.salary)
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

/* Show a list of employees who have dependents and their dependent's relationship. */
SELECT e.employee_id, e.first_name, e.last_name, d.relationship
FROM employees e
JOIN dependents d ON e.employee_id = d.employee_id;

/* Display the total number of employees in each region and their average salary. */
SELECT r.region_name, COUNT(e.employee_id) as num_employees, AVG(e.salary) as avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN regions r ON c.region_id = r.region_id
GROUP BY r.region_name;

/* Show a list of employees who have the same job title as their manager. */
SELECT e.employee_id, e.first_name, e.last_name, j.job_title
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
JOIN jobs j ON e.job_id = j.job_id
WHERE j.job_title = (SELECT job_title FROM jobs WHERE job_id = m.job_id);

/* Display the total number of employees in each job title and their minimum salary. */
SELECT j.job_title, COUNT(e.employee_id) as num_employees, MIN(e.salary) as min_salary
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title;

/* List all employees who work in the region "Americas" and have a salary greater than $60,000. */
SELECT e.employee_id, e.first_name, e.last_name, e.salary, c.country_name, r.region_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN regions r ON c.region_id = r.region_id
WHERE r.region_name = 'Americas' AND e.salary > 60000;

/* List all employees who work in the department "Sales" and have a salary between $50,000 and $80,000. */
SELECT e.employee_id, e.first_name, e.last_name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Sales' AND e.salary BETWEEN 50000 AND 80000;

/* List all employees who have the job title "Marketing Manager" and work in the region "Europe". */
SELECT e.employee_id, e.first_name, e.last_name, j.job_title, r.region_name
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN regions r ON c.region_id = r.region_id
WHERE j.job_title = 'Marketing Manager' AND r.region_name = 'Europe';

/* List all departments and the total salary of all employees in each department. */
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

