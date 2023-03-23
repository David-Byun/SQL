/* Updating an employee's salary */

UPDATE employees
SET salary = 50000
WHERE employee_id = 123;

/* Deleting a department and reassigning its employees to a different department: */
DELETE FROM departments
WHERE department_id = 456;

UPDATE employees
SET department_id = 789
WHERE department_id = 456;

/* Updating the region name for a specific region: */
UPDATE regions
SET region_name = 'North America'
WHERE region_id = 1;

/* Updating the job title and salary range for a specific job: */
UPDATE jobs
SET job_title = 'Manager', min_salary = 60000, max_salary = 90000
WHERE job_id = 456;