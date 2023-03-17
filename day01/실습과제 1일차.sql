/* 실습과제 139P */
SELECT EMPNO AS EMPLOYEE_NO
        , ENAME AS EMPLOYEE_NAME
        , JOB
        , MGR AS MANAGER
        , HIREDATE
        , SAL AS SALARY
        , COMM AS COMMISSION
        , DEPTNO AS DEPARTMENT_NO
FROM EMP
ORDER BY DEPTNO DESC, ENAME ASC

/* 실습과제 146P */
SELECT * FROM EMP
        WHERE COMM IN NULL AND SAL > NULL;
SELECT * FROM EMP
        WHERE MGR IS NULL AND COMM IS NULL;

/* 실습과제 150P 1번 */
SELECT *
FROM EMP
WHERE ENAME LIKE ('%S')

/* 실습과제 150P 2번 */
SELECT *
FROM EMP
WHERE JOB = 'SALESMAN' AND DEPTNO = 30

/* 실습과제 150P 3번 */
SELECT *
FROM EMP
WHERE DEPTNO IN (20, 30)
AND SAL > 2000

/* 실습과제 150P 4번 */
SELECT *
FROM EMP
WHERE SAL > 2000
AND DEPTNO = 20
UNION
SELECT *
FROM EMP
WHERE DEPTNO = 30

/* 실습과제 150P 5번 */
SELECT *
FROM EMP
WHERE JOB IN ('MANAGER', 'CLERK')
AND ENAME NOT LIKE ('_L%')
AND EMPNO IN
(SELECT EMPNO FROM EMP
WHERE COMM IS NULL
AND MGR IS NOT NULL)

/* 실습과제 169P 1번 */
SELECT EMPNO, ENAME
    , SUBSTR(EMPNO, 1, 2) || LPAD('*', LENGTH(EMPNO)-2, '*') AS EMPNO_마스킹_처리
    , SUBSTR(ENAME, 1, 1) || LPAD('*', LENGTH(ENAME)-1, '*') AS ENAME_마스킹_처리
FROM EMP
WHERE LENGTH(ENAME) >= 6

/* 실습과제 169P 2번 */
SELECT EMPNO, ENAME,
       JOB,
       SAL,
       SAL / 20 AS DAY_PER_SAL,
       SAL / 20 / 8 AS HOUR_PER_SAL
FROM EMP
WHERE JOB IN ('SALESMAN', 'CLERK')
ORDER BY SAL ASC;

/* 실습과제 170P 3번*/
SELECT EMPNO, ENAME, HIREDATE,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
    NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP


/* 실습과제 170P 4번*/
SELECT EMPNO, ENAME, MGR
    , CASE
        WHEN MGR IS NULL THEN '0000'
        WHEN SUBSTR(MGR,1,2) = '75' THEN '5555'
        WHEN SUBSTR(MGR,1,2) = '76' THEN '6666'
        WHEN SUBSTR(MGR,1,2) = '77' THEN '7777'
        WHEN SUBSTR(MGR,1,2) = '78' THEN '8888'
        ELSE '9999'
        END AS CHG_MGR
FROM EMP

























