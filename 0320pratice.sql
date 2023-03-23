/* 실습과제 186 1번 */
SELECT DEPTNO, TRUNC(AVG(SAL)) AS AVG_SAL, MAX(SAL) AS MAS_SAL, MIN(SAL) AS MIN_SAL, COUNT(*) AS CNT
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO DESC

/* 실습과제 186 2번 */
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3

/* 실습과제 186 3번 */
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_DATE, DEPTNO, COUNT(*) CNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO

/* 실습과제 187 4번 */
SELECT NVL2(COMM, 'Y', 'N') AS EXIST_COMM,
       COUNT(*) AS CNT
FROM EMP
GROUP BY NVL2(COMM, 'Y', 'N')

SELECT * FROM EMP

/* 실습과제 187 5번 */
SELECT DEPTNO, TO_CHAR(HIREDATE, 'YYYY') AS HIRE_DATE, COUNT(*) AS CNT, MAX(SAL) AS MAX_SAL, SUM(SAL) AS SUM_SAL, AVG(SAL) AS AVG_SAL
FROM EMP
GROUP BY ROLLUP (DEPTNO, TO_CHAR(HIREDATE, 'YYYY'))

SELECT *
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
ORDER BY EMPNO

SELECT *
FROM EMP E JOIN DEPT D USING (DEPTNO)
ORDER BY E.EMPNO

SELECT E1.EMPNO
    , E1.ENAME
    , E1.MGR
    , E2.EMPNO AS MGR_EMPNO
    , E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO

SELECT E1.EMPNO
    , E1.ENAME
    , E1.MGR
    , E2.EMPNO AS MGR_EMPNO
    , E2.ENAME AS MGR_ENAME
FROM EMP E1 LEFT OUTER JOIN EMP E2
    ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO

SELECT E1.EMPNO
    , E1.ENAME
    , E1.MGR
    , E2.EMPNO AS MGR_EMPNO
    , E2.ENAME AS MGR_ENAME
FROM EMP E1 RIGHT OUTER JOIN EMP E2
    ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO

SELECT * FROM EMP

SELECT * FROM DEPT

SELECT D.DEPTNO
    , E.JOB AS DNAME
    , E.EMPNO
    , E.ENAME
    , E.SAL
FROM EMP E JOIN DEPT D ON E.SAL > 2000
ORDER BY D.DEPTNO, E.JOB ASC

SELECT D.DEPTNO
    , E.JOB AS DNAME
    , E.EMPNO
    , E.ENAME
    , E.SAL
FROM EMP E, DEPT D
WHERE E.SAL > 2000
ORDER BY D.DEPTNO, E.JOB ASC

SELECT *
FROM EMP E JOIN DEPT D ON(E.DEPTNO = D.DEPTNO)
ORDER BY EMPNO

SELECT E.DEPTNO
    , D.DNAME
    , FLOOR(AVG(E.SAL)) AS AVG_SAL
    , MAX(E.SAL) AS MAX_SAL
    , MIN(E.SAL) AS MIN_SAL
    , COUNT(E.DEPTNO) AS CNT
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO, D.DNAME
ORDER BY E.DEPTNO, D.DNAME

SELECT * FROM EMP

SELECT * FROM DEPT

SELECT E.DEPTNO
    , D.DNAME
    , E.EMPNO
    , E.ENAME
    , E.JOB
    , E.SAL
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
ORDER BY E.DEPTNO, D.DNAME

SELECT D.DEPTNO AS DEPTNO
    , D.DNAME
    , E.EMPNO
    , E.ENAME
    , E.MGR
    , E.SAL
    , E.DEPTNO AS DEPTNO
    , S.LOSAL
    , S.HISAL
    , S.GRADE
    , E2.EMPNO AS MGR_EMPNO
    , E2.ENAME AS MGR_ENAME
FROM EMP E RIGHT JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
LEFT OUTER JOIN SALGRADE S ON (E.SAL >= S.LOSAL AND E.SAL <= S.HISAL)
LEFT OUTER JOIN EMP E2 ON (E.MGR = E2.EMPNO)
ORDER BY D.DEPTNO, E.EMPNO



WHERE E.DEPTNO(+) = D.DEPTNO
AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
AND E.MGR = E2.EMPNO(+)
ORDER BY D.DEPTNO, E.EMPNO

SELECT * FROM SALGRADE

SELECT D.DEPTNO AS DEPTNO
    , D.DNAME
    , E.EMPNO
    , E.ENAME
    , E.MGR
    , E.SAL
    , E.DEPTNO AS DEPTNO
    , S.LOSAL
    , S.HISAL
    , S.GRADE
    , E2.EMPNO AS MGR_EMPNO
    , E2.ENAME AS MGR_ENAME
FROM EMP E RIGHT JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
LEFT OUTER JOIN SALGRADE S ON (E.SAL >= S.LOSAL AND E.SAL <= S.HISAL)
LEFT OUTER JOIN EMP E2 ON (E.MGR = E2.EMPNO)
ORDER BY D.DEPTNO, E.EMPNO

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
    AND E.SAL > (SELECT AVG(SAL) FROM EMP)

SELECT * FROM EMP

SELECT * FROM DEPT

SELECT DEPTNO, ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
                FROM EMP
                GROUP BY DEPTNO)

SELECT DEPTNO, ENAME, SAL
FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL)
                    FROM EMP
                    GROUP BY DEPTNO)

SELECT *
FROM EMP
WHERE SAL < ANY (SELECT SAL
                    FROM EMP
                    WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO

SELECT *
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                            FROM EMP
                            GROUP BY DEPTNO)

SELECT DEPTNO, MAX(SAL)
                            FROM EMP
                            GROUP BY DEPTNO
SELECT E.EMPNO
    , E.ENAME
    , E.DEPTNO
    , D.DNAME
    , D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E
    , (SELECT * FROM DEPT) D
WHERE E.DEPTNO = D.DEPTNO

SELECT * FROM DEPT

SELECT * FROM EMP

SELECT E.JOB
    , E.EMPNO
    , E.ENAME
    , E.SAL
    , D.DEPTNO
    , D.DNAME
FROM DEPT D, EMP E
WHERE E.JOB = (SELECT JOB FROM EMP WHERE ENAME = 'ALLEN')


SELECT * FROM EMP