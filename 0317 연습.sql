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
AND ENAME NOT LIKE ('_S%')
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

SELECT EMPNO, ENAME, HIREDATE,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
    NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP

/* TO_CHAR() 날짜, 숫자 등의 값을 문자열로 변환하는 함수 */
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD'),
       TO_CHAR(SYSDATE, 'YYYY/MM/DD'),
       TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL

/* 문자열의 공백 제거 */
SELECT TO_CHAR(123.456, 'FM990.999'),
       TO_CHAR(1234.56, 'FM9990.99'),
       TO_CHAR(0.12345, 'FM9990.99')
FROM DUAL

SELECT TO_CHAR(SYSDATE, '""YYYY"년 "MM"월 "DD"일"')
    , TO_CHAR(SYSDATE, '""HH24"시 "MI"분 "SS"초')
FROM DUAL

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB

SELECT DEPTNO
    , JOB
    , COUNT(*)
    , MAX(SAL)
    , SUM(SAL)
    , AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO

SELECT * FROM DEPT

SELECT *
FROM EMP E JOIN DEPT D
    ON (E.DEPTNO = D.DEPTNO)
ORDER BY EMPNO;

SELECT * FROM SALGRADE

SELECT ENAME, JOB, SAL, GRADE ,LOSAL, HISAL
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL

SELECT E1.EMPNO
    , E1.ENAME
    , E1.MGR
    , E2.EMPNO AS MGR_EMPNO
    , E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
ORDER BY E1.EMPNO

SELECT ENAME
FROM EMP
WHERE DEPTNO = '20'

SELECT D.DEPTNO
    , D.DNAME
    , E.EMPNO
    , E.ENAME
    , E.MGR
    , E.SAL
    , E.DEPTNO
    , S.LOSAL
    , S.HISAL
    , S.GRADE
    , E2.EMPNO AS MGR_EMPNO
    , E2.ENAME AS MGR_ENAME
FROM EMP E, DEPT D, SALGRADE S, EMP E2
WHERE E.DEPTNO(+) = D.DEPTNO
AND E.MGR = E2.EMPNO(+)

SELECT D.DEPTNO
    , D.DNAME
    , E.EMPNO
    , E.ENAME
    , E.MGR
    , E.SAL
    , E.DEPTNO
    , S.LOSAL
    , S.HISAL
    , S.GRADE
    , E2.EMPNO AS MGR_EMPNO
FROM EMP E RIGHT JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)

SELECT D.DEPTNO
    , D.DNAME
    , E.EMPNO
    , E.ENAME
    , E.MGR
    , E.SAL
    , E.DEPTNO
    , S.LOSAL
    , S.HISAL
    , S.GRADE
    , E2.EMPNO AS MGR_EMPNO
FROM EMP E RIGHT JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
LEFT OUTER JOIN SALGRADE S ON (E.SAL >= S.LOSAL AND E.SAL <= S.HISAL)
LEFT OUTER JOIN EMP E2 ON (E.MGR = E2.EMPNO)
ORDER BY D.DEPTNO, E.EMPNO

SELECT *
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'BLAKE')

SELECT *
FROM EMP
WHERE HIREDATE < (SELECT HIREDATE
                            FROM EMP
                            WHERE ENAME = 'BLAKE')

SELECT E.EMPNO
        , E.ENAME
        , E.JOB
        , E.SAL
        , D.DEPTNO
        , D.DNAME
        , D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 20
    AND E.SAL > (SELECT AVG(SAL)
                    FROM EMP)

SELECT *
FROM EMP
WHERE SAL < ANY (SELECT SAL
                    FROM EMP
                    WHERE DEPTNO=30)
ORDER BY SAL, EMPNO

SELECT EMPNO, ENAME, DEPINO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO = 20

SELECT *
FROM EMP
WHERE SAL < ANY(SELECT SAL
                    FROM EMP
                    WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO

SELECT * FROM V$SQLFN_METADATA

SELECT *
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO)

SELECT * FROM DEPT_TEMP2

UPDATE DEPT_TEMP2 SET LOC ='SEOUL'

SELECT '010-1234-5678' AS REPLACE_BEFORE
    , REPLACE('010-1234-5678', '-', '') AS REPLACE_1
    , REPLACE('010-1234-5678', '-') AS REPLACE_2
FROM DUAL;

SELECT SIGN(-100), SIGN(100), SIGN(0)
FROM DUAL

SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 12 * 20) AS WORK10YEAR
FROM EMP;

SELECT TO_CHAR(123467, 'FM999,999')
    , TO_CHAR(123467890, 'FM999,999,999')
FROM DUAL

SELECT TO_DATE('2023/02/15', 'YYYY/MM/DD') AS TODATE1
FROM DUAL

SELECT *
FROM EMP
WHERE HIREDATE > TO_DATE('1981/07/01', 'YYYY/MM/DD')

SELECT *
FROM EMP E JOIN DEPT D
    USING(DEPTNO)
ORDER BY E.EMPNO;




