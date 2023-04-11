CREATE TABLE Address
(name       VARCHAR(32) NOT NULL,
 phone_nbr  VARCHAR(32) ,
 address    VARCHAR(32) NOT NULL,
 sex        CHAR(4) NOT NULL,
 age        INTEGER NOT NULL,
 PRIMARY KEY (name));

INSERT INTO Address VALUES('인성아',   '080-3333-XXXX', '서울시',   '남', 30);
INSERT INTO Address VALUES('하진아',   '090-0000-XXXX', '서울시',   '여', 21);
INSERT INTO Address VALUES('준아',     '090-2984-XXXX', '서울시',   '남', 45);
INSERT INTO Address VALUES('민아',     '080-3333-XXXX', '부산시',   '남', 32);

select * from address

select name, address,
       case when address = '서울시' then '경기도'
            when address = '인천시' then '경기도'
            when address = '속초시' then '강원도'
       else null end as district
from Address

select address, count(*) as '인원수'
from Address
group by address;

select address, count(*) over (partition by address) as '인원수'
from address

SELECT name
        , age
        , RANK() OVER(ORDER BY age DESC) AS RNK
FROM Address

SELECT name
        , age
        , RANK() OVER(ORDER BY age DESC) AS RNK
FROM Address

DELETE FROM Address
WHERE ADDRESS='인천시'

UPDATE Address
SET phone_nbr = '080-5849-XXXX'
WHERE name = "빛나래";

UPDATE ADDRESS
SET PHONE_NBR = '080-5848-XXXX', AGE =20
WHERE NAME = '빛나래';

UPDATE Address
SET (PHONE_NBR, AGE) = ('080-4534-2323', 20)
WHERE name="빛나래";

CREATE TABLE Items
(   item_id     INTEGER  NOT NULL,
       year     INTEGER  NOT NULL,
  item_name     CHAR(32) NOT NULL,
  price_tax_ex  INTEGER  NOT NULL,
  price_tax_in  INTEGER  NOT NULL,
  PRIMARY KEY (item_id, year));

select * from items;

INSERT INTO Items VALUES(100, 2000, '머그컵' ,500, 525);
INSERT INTO Items VALUES(100, 2001, '머그컵' ,520, 546);
INSERT INTO Items VALUES(100, 2002, '머그컵' ,600, 630);
INSERT INTO Items VALUES(100, 2003, '머그컵' ,600, 630);
INSERT INTO Items VALUES(101, 2000, '티스푼' ,500, 525);
INSERT INTO Items VALUES(101, 2001, '티스푼' ,500, 525);
INSERT INTO Items VALUES(101, 2002, '티스푼' ,500, 525);
INSERT INTO Items VALUES(101, 2003, '티스푼' ,500, 525);
INSERT INTO Items VALUES(102, 2000, '나이프' ,600, 630);
INSERT INTO Items VALUES(102, 2001, '나이프' ,550, 577);
INSERT INTO Items VALUES(102, 2002, '나이프' ,550, 577);
INSERT INTO Items VALUES(102, 2003, '나이프' ,400, 420);

select item_name, year,
       case when year >= 2002 then price_tax_in
            when year <= 2001 then price_tax_ex end as price
from Items


CREATE TABLE Population
(prefecture VARCHAR(32),
 sex        CHAR(1),
 pop        INTEGER,
     CONSTRAINT pk_pop PRIMARY KEY(prefecture, sex));

INSERT INTO Population VALUES('성남', '1', 60);
INSERT INTO Population VALUES('성남', '2', 40);
INSERT INTO Population VALUES('수원', '1', 90);
INSERT INTO Population VALUES('수원', '2',100);
INSERT INTO Population VALUES('광명', '1',100);
INSERT INTO Population VALUES('광명', '2', 50);
INSERT INTO Population VALUES('일산', '1',100);
INSERT INTO Population VALUES('일산', '2',100);
INSERT INTO Population VALUES('용인', '1', 20);
INSERT INTO Population VALUES('용인', '2',200);

select * from Population;

select prefecture,
       sum(case when sex = 1 then pop else 0 end) as pop_men,
       sum(case when sex = 2 then pop else 0 end) as pop_wom
from Population
group by prefecture

select * from Employees

INSERT INTO Employees VALUES('201', 1, 'Joe', '상품기획');
INSERT INTO Employees VALUES('201', 2, 'Joe', '개발');
INSERT INTO Employees VALUES('201', 3, 'Joe', '영업');
INSERT INTO Employees VALUES('202', 2, 'Jim', '개발');
INSERT INTO Employees VALUES('203', 3, 'Carl', '영업');
INSERT INTO Employees VALUES('204', 1, 'Bree', '상품기획');
INSERT INTO Employees VALUES('204', 2, 'Bree', '개발');
INSERT INTO Employees VALUES('204', 3, 'Bree', '영업');
INSERT INTO Employees VALUES('204', 4, 'Bree', '관리');
INSERT INTO Employees VALUES('205', 1, 'Kim', '상품기획');
INSERT INTO Employees VALUES('205', 2, 'Kim', '개발');

/*
    소속팀이 1개면 직원은 팀의 이름을 그대로 출력한다
    소속팀이 2개면 해당 직원은 '2개를 겸무'라는 문자열을 출력한다
    소소팀이 3개 이상이라면 해당 직원은 '3개 이상을 겸무'라는 문자열을 출력한다
*/

select emp_name,
       case when count(team_id) = 1 then Max(team)
            when count(team_id) = 2 then '2개를 겸무'
            when count(team_id) >= 3 then '3개 이상을 겸무'
       end as team
from Employees
group by emp_name


MIN, AVG. SUM 등의 함수를 사용해도 현 예제에서는 상관 없지만,
문자 또는 날짜 등도 마찬가지로 통일해서 사용하려면 MAX 또는 MIN을 사용하는 습관을 들이는 것이 좋습니다.


CREATE TABLE NonAggTbl
(id VARCHAR(32) NOT NULL,
 data_type CHAR(1) NOT NULL,
 data_1 INTEGER,
 data_2 INTEGER,
 data_3 INTEGER,
 data_4 INTEGER,
 data_5 INTEGER,
 data_6 INTEGER);

CREATE TABLE NonAggTbl
(id VARCHAR(32) NOT NULL,
 data_type CHAR(1) NOT NULL,
 data_1 INTEGER,
 data_2 INTEGER,
 data_3 INTEGER,
 data_4 INTEGER,
 data_5 INTEGER,
 data_6 INTEGER);


INSERT INTO NonAggTbl VALUES('Jim',    'A',  100,  10,     34,  346,   54,  NULL);
INSERT INTO NonAggTbl VALUES('Jim',    'B',  45,    2,    167,   77,   90,   157);
INSERT INTO NonAggTbl VALUES('Jim',    'C',  NULL,  3,    687, 1355,  324,   457);
INSERT INTO NonAggTbl VALUES('Ken',    'A',  78,    5,    724,  457, NULL,     1);
INSERT INTO NonAggTbl VALUES('Ken',    'B',  123,  12,    178,  346,   85,   235);
INSERT INTO NonAggTbl VALUES('Ken',    'C',  45, NULL,     23,   46,  687,    33);
INSERT INTO NonAggTbl VALUES('Beth',   'A',  75,    0,    190,   25,  356,  NULL);
INSERT INTO NonAggTbl VALUES('Beth',   'B',  435,   0,    183, NULL,    4,   325);
INSERT INTO NonAggTbl VALUES('Beth',   'C',  96,  128,   NULL,    0,    0,    12);

select * from NonAggTbl

SELECT id
        , MAX(CASE WHEN data_type='A' THEN data_1 ELSE NULL END) AS data_1
        , MAX(CASE WHEN data_type='A' THEN data_2 ELSE NULL END) AS data_2
        , MAX(CASE WHEN data_type='B' THEN data_3 ELSE NULL END) AS data_3
        , MAX(CASE WHEN data_type='B' THEN data_4 ELSE NULL END) AS data_4
        , MAX(CASE WHEN data_type='B' THEN data_5 ELSE NULL END) AS data_5
        , MAX(CASE WHEN data_type='C' THEN data_6 ELSE NULL END) AS data_6
FROM NonAggTbl
GROUP BY id;

CREATE TABLE PriceByAge
(
    pruduct_id VARCHAR(32) NOT NULL,
    low_age INTEGER NOT NULL,
    high_age INTEGER NOT NULL,
    price INTEGER NOT NULL,
    PRIMARY KEY (pruduct_id, low_age),
    CHECK (low_age < high_age)
);

select * from PriceByAge;


INSERT INTO PriceByAge VALUES('제품1',  0  ,  50  ,  2000);
INSERT INTO PriceByAge VALUES('제품1',  51 ,  100 ,  3000);
INSERT INTO PriceByAge VALUES('제품2',  0  ,  100 ,  4200);
INSERT INTO PriceByAge VALUES('제품3',  0  ,  20  ,  500);
INSERT INTO PriceByAge VALUES('제품3',  31 ,  70  ,  800);
INSERT INTO PriceByAge VALUES('제품3',  71 ,  100 ,  1000);
INSERT INTO PriceByAge VALUES('제품4',  0  ,  99  ,  8900);

SELECT pruduct_id
from PriceByAge
GROUP BY pruduct_id
HAVING SUM(high_age - low_age + 1) = 101;

CREATE TABLE HotelRooms
(
    room_nbr INTEGER,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY(room_nbr, start_date)
);

INSERT INTO HotelRooms VALUES(101, '2008-02-01', '2008-02-06');
INSERT INTO HotelRooms VALUES(101, '2008-02-06', '2008-02-08');
INSERT INTO HotelRooms VALUES(101, '2008-02-10', '2008-02-13');
INSERT INTO HotelRooms VALUES(202, '2008-02-05', '2008-02-08');
INSERT INTO HotelRooms VALUES(202, '2008-02-08', '2008-02-11');
INSERT INTO HotelRooms VALUES(202, '2008-02-11', '2008-02-12');
INSERT INTO HotelRooms VALUES(303, '2008-02-03', '2008-02-17');

select * from HotelRooms

이 테이블에서 사람들이 숙박한 날이 10일 이상인 방을 선택

SELECT room_nbr,
       SUM(end_date - start_date) as working_days
FROM HotelRooms
GROUP BY room_nbr
HAVING SUM(end_date - start_date) >= 10

CREATE TABLE Persons
(
    name VARCHAR(8) NOT NULL,
    age INTEGER NOT NULL,
    height FLOAT NOT NULL,
    weight FLOAT NOT NULL,
    PRIMARY KEY(name)
);

select * from Persons;

INSERT INTO Persons VALUES('Anderson',  30,  188,  90);
INSERT INTO Persons VALUES('Adela',    21,  167,  55);
INSERT INTO Persons VALUES('Bates',    87,  158,  48);
INSERT INTO Persons VALUES('Becky',    54,  187,  70);
INSERT INTO Persons VALUES('Bill',    39,  177,  120);
INSERT INTO Persons VALUES('Chris',    90,  175,  48);
INSERT INTO Persons VALUES('Darwin',  12,  160,  55);
INSERT INTO Persons VALUES('Dawson',  25,  182,  90);
INSERT INTO Persons VALUES('Donald',  30,  176,  53);

SELECT SUBSTR(name, 1, 1) AS label
        , COUNT(*) AS COUNT
FROM Persons
GROUP BY SUBSTR(name, 1, 1)

SELECT CASE WHEN age < 20 THEN '어린이'
            WHEN age BETWEEN 20 AND 69 THEN '성인'
            WHEN age >= 70 THEN '노인'
            ELSE NULL END AS age_class,
        COUNT(*)
FROM Persons
GROUP BY CASE WHEN age < 20 THEN '어린이'
              WHEN age BETWEEN 20 AND 69 THEN '성인'
              WHEN age >= 70 THEN '노인'
              ELSE NULL END;

BMI로 자르기

SELECT CASE WHEN weight / POWER(height / 100, 2) < 18.5 THEN '저체중'
FROM Persons



































