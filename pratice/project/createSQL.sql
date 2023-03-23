CREATE TABLE regions (
	region_id NUMBER PRIMARY KEY,
	region_name VARCHAR2 (25)
);

CREATE TABLE countries (
	country_id CHAR (2) PRIMARY KEY,
	country_name VARCHAR2 (40),
	region_id NUMBER NOT NULL,
	CONSTRAINT countries_fk_regions FOREIGN KEY (region_id) REFERENCES regions (region_id) ON DELETE CASCADE
);

CREATE TABLE locations (
	location_id NUMBER PRIMARY KEY,
	street_address VARCHAR2 (40),
	postal_code VARCHAR2 (12),
	city VARCHAR2 (30) NOT NULL,
	state_province VARCHAR2 (25),
	country_id CHAR (2) NOT NULL,
	CONSTRAINT locations_fk_countries FOREIGN KEY (country_id) REFERENCES countries (country_id) ON DELETE CASCADE
);

CREATE TABLE jobs (
	job_id NUMBER PRIMARY KEY,
	job_title VARCHAR2 (35) NOT NULL,
	min_salary NUMBER (8, 2),
	max_salary NUMBER (8, 2)
);

CREATE TABLE departments (
	department_id NUMBER PRIMARY KEY,
	department_name VARCHAR2 (30) NOT NULL,
	location_id NUMBER,
	CONSTRAINT departments_fk_locations FOREIGN KEY (location_id) REFERENCES locations (location_id) ON DELETE CASCADE
);

CREATE TABLE employees (
	employee_id NUMBER PRIMARY KEY,
	first_name VARCHAR2 (20),
	last_name VARCHAR2 (25) NOT NULL,
	email VARCHAR2 (100) NOT NULL,
	phone_number VARCHAR2 (20),
	hire_date DATE NOT NULL,
	job_id NUMBER NOT NULL,
	salary NUMBER (8, 2) NOT NULL,
	manager_id NUMBER,
	department_id NUMBER,
	CONSTRAINT employees_fk_jobs FOREIGN KEY (job_id) REFERENCES jobs (job_id) ON DELETE CASCADE,
	CONSTRAINT employees_fk_departments FOREIGN KEY (department_id) REFERENCES departments (department_id) ON DELETE CASCADE,
	CONSTRAINT employees_fk_manager FOREIGN KEY (manager_id) REFERENCES employees (employee_id)
);

CREATE TABLE dependents (
	dependent_id NUMBER PRIMARY KEY,
	first_name VARCHAR2 (50) NOT NULL,
	last_name VARCHAR2 (50) NOT NULL,
	relationship VARCHAR2 (25) NOT NULL,
	employee_id NUMBER NOT NULL,
	CONSTRAINT dependents_fk_employees FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE
);