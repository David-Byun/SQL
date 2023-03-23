CREATE TABLE regions (
	region_id NUMBER PRIMARY KEY,
	region_name VARCHAR2 (25)
);

CREATE TABLE departments (
	department_id NUMBER PRIMARY KEY,
	department_title VARCHAR2 (35) NOT NULL,
	min_salary NUMBER (8, 2),
	max_salary NUMBER (8, 2)
);

CREATE TABLE employees (
	employee_id NUMBER PRIMARY KEY,
	name VARCHAR2 (20) NOT NULL,
	hire_date DATE NOT NULL,
	salary NUMBER (8, 2) NOT NULL,
	manager_id NUMBER,
	region_id NUMBER,
	department_id NUMBER,
	CONSTRAINT employees_fk_lectures FOREIGN KEY (lectures) REFERENCES lectures (lecture_id) ON DELETE CASCADE,
	CONSTRAINT employees_fk_regions FOREIGN KEY (training_id) REFERENCES TRAININGS (training_id) ON DELETE CASCADE,
	CONSTRAINT employees_fk_departments FOREIGN KEY (department_id) REFERENCES departments (department_id) ON DELETE CASCADE
);

CREATE TABLE lectures (
    lecture_id NUMBER PRIMARY KEY,
    lecture_name VARCHAR2(20)
)

CREATE TABLE TRAININGS (
    training_id NUMBER PRIMARY KEY,
    training_name VARCHAR2(20)
)

/*Data for the table regions*/
INSERT INTO regions(region_id,region_name) VALUES (1,'서울');
INSERT INTO regions(region_id,region_name) VALUES (2,'인천');
INSERT INTO regions(region_id,region_name) VALUES (3,'경기');
INSERT INTO regions(region_id,region_name) VALUES (4,'부산');
INSERT INTO regions(region_id,region_name) VALUES (5,'전주');
INSERT INTO regions(region_id,region_name) VALUES (6,'제주');

/* DEPARTMENT */
INSERT INTO departments(department_id,department_title,min_salary,max_salary) VALUES (1,'개인여신',4200.00,9000.00);
INSERT INTO departments(department_id,department_title,min_salary,max_salary) VALUES (2,'기업여신',3000.00,6000.00);
INSERT INTO departments(department_id,department_title,min_salary,max_salary) VALUES (3,'수신',20000.00,40000.00);
INSERT INTO departments(department_id,department_title,min_salary,max_salary) VALUES (4,'플랫폼',15000.00,30000.00);
INSERT INTO departments(department_id,department_title,min_salary,max_salary) VALUES (5,'CIB',4200.00,9000.00);
INSERT INTO departments(department_id,department_title,min_salary,max_salary) VALUES (6,'인사',8200.00,16000.00);
INSERT INTO departments(department_id,department_title,min_salary,max_salary) VALUES (7,'마케팅',4000.00,9000.00);
INSERT INTO departments(department_id,department_title,min_salary,max_salary) VALUES (8,'보안',4000.00,10000.00);
INSERT INTO departments(department_id,department_title,min_salary,max_salary) VALUES (9,'영업',9000.00,15000.00);
INSERT INTO departments(department_id,department_title,min_salary,max_salary) VALUES (10,'후선센터',4000.00,9000.00);


/* Employee */
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (1,'홍길동','2004-01-02',5500,2,3,1);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (2,'이사바','2015-02-02',3400,3,4,2);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (3,'아로이','2020-09-02',2100,4,5,3);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (4,'신라이','2023-02-01',8300,5,6,4);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (5,'삼양이','2014-12-01',12000,6,1,5);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (6,'구니비','2009-10-04',9000,7,2,6);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (7,'이창이','2018-06-12',11000,3,2,7);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (8,'호로이','2012-08-17',21000,3,3,8);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (9,'바라이','2014-03-02',21000,4,4,8);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (10,'소소이','2020-05-04',21000,9,5,10);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (11,'하잇','2005-08-04',11000,7,2,1);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (12,'상잇','2014-03-12',12000,3,1,2);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (13,'바잇','2013-04-17',23000,3,4,3);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (14,'호우','2012-06-02',19000,4,2,4);
INSERT INTO employees(employee_id,name,hire_date,salary,manager_id,region_id, department_id)
VALUES (15,'경보','2010-05-04',3000,9,3,5);

/*
    특정 목적 기능
    1. 10년 이상 한 부서에 근무한 직원은 부서를 변경해야 한다
    2. SALARY가 해당 부서 MAX SALARY보다 초과할 경우는 MAX SALARY를 주고, MIN SALARY 보다 낮은 경우 MIN SALARY를 준다
    3. SALARY 범위별 직원수를 구하고, 해당 구간별 평균 근속년수를 구한다. 평균 근속년수보다 높은 직원들은 매니저가 본인 자신이 된다.
 */




 /*
    기타 검색 조건
    전체 직원 조회
    지역별 직원 조회
    부서별 직원 조회
  */

/* 전체 직원 조회 */
SELECT E.NAME, E.HIRE_DATE, E.SALARY, R.region_name, D.department_title
FROM EMPLOYEES E, REGIONS R, DEPARTMENTS D
WHERE R.region_id = E.region_id
AND D.department_id = E.department_id

/* 지역별 직원 조회 */
SELECT R.REGION_NAME, E.NAME, E.HIRE_DATE, E.SALARY
FROM EMPLOYEES E, REGIONS R
WHERE E.REGION_ID = R.REGION_ID
ORDER BY REGION_NAME DESC

/* 지역별 평균 SALARY 조회 */
SELECT R.REGION_NAME, FLOOR(AVG(E.SALARY)) AS 평균급여
FROM EMPLOYEES E, REGIONS R
WHERE E.REGION_ID = R.REGION_ID
GROUP BY REGION_NAME

/* 부서별 직원 조회 */
SELECT D.DEPARTMENT_TITLE, E.NAME, E.HIRE_DATE, E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY department_title

/* 부서별 평균 SALARY 조회 */
SELECT D.DEPARTMENT_TITLE, FLOOR(AVG(E.SALARY)) AS 평균급여
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY DEPARTMENT_TITLE
