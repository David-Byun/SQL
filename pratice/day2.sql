select * from Address;

select sex,
       COUNT(*)
from Address
group by sex;

select address,
       count(*)
from Address
group by address;

select address, count(*)
from Address
group by address
having count(*) = 1;

create view CountAddress (v_address, cnt)
as
select address, count(*)
from Address
Group By address;

select * from CountAddress;

select v_address, cnt from CountAddress;
select v_address, cnt
from (select address as v_address, count(*) as cnt
      from Address
      group by address) as CountAddress;

CREATE TABLE Address2
(name       VARCHAR(32) NOT NULL,
 phone_nbr  VARCHAR(32) ,
 address    VARCHAR(32) NOT NULL,
 sex        CHAR(4) NOT NULL,
 age        INTEGER NOT NULL,
 PRIMARY KEY (name));

INSERT INTO Address2 VALUES('인성', '080-3333-XXXX', '서울시', '남', 30);
INSERT INTO Address2 VALUES('민',   '080-3333-XXXX', '부산시', '남', 32);
INSERT INTO Address2 VALUES('준서', NULL,            '부산시', '남', 18);
INSERT INTO Address2 VALUES('지연', '080-2367-XXXX', '인천시', '여', 19);
INSERT INTO Address2 VALUES('서준', NULL,            '인천시', '여', 20);
INSERT INTO Address2 VALUES('중진', '090-0205-XXXX', '속초시', '남', 25);

select name
from Address
where name in (select name from Address2);

select *
from Address;

select name, address,
       case when address = '서울시' then '경기'
            when address = '인천시' then '경기'
            when address = '부산시' then '영남'
            when address = '속초시' then '관동'
            when address = '서귀포시' then '호남'
            else null end as district
from Address;
select *
from Address
union
select *
from Address2;

# UNION : 합집합 - 중복집합
# UNION ALL : 전체 집합
# INTERSECT : 공통으로 존재하는 레코드 출력

select address, count(*)
from Address
group by address;

select address,
       count(*) over(partition by address)
from Address;

#RANK 함수는 숫자가 같으면 같은 순위로 표시하고, DENSE_RANK 건너뛰는 작업 없이 순위를 구하고 싶을 때
select name,
       age,
       rank() over(order by age desc) as rnk
from Address;

select name,
       age,
       dense_rank() over (order by age desc) as dense_rnk
from Address;

#조건 분기를 WHERE 구로 하는 사람들은 초보자다. 잘하는 사람은 SELECT 구만으로 조건 분기를 한다.
CREATE TABLE Items
(   item_id     INTEGER  NOT NULL,
       year     INTEGER  NOT NULL,
  item_name     CHAR(32) NOT NULL,
  price_tax_ex  INTEGER  NOT NULL,
  price_tax_in  INTEGER  NOT NULL,
  PRIMARY KEY (item_id, year));

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

select item_name,
       year,
       case when year <= 2001 then price_tax_ex
            when year >= 2002 then price_tax_in end as price
from items;

select * from items;

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

select item_name, year,
       case when year <= 2001 then price_tax_ex
            when year > 2002 then price_tax_in end as price
from items;

CREATE TABLE Employees
(emp_id    CHAR(3)  NOT NULL,
 team_id   INTEGER  NOT NULL,
 emp_name  CHAR(16) NOT NULL,
 team      CHAR(16) NOT NULL,
    PRIMARY KEY(emp_id, team_id));

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

select prefecture,
       sum(case when sex = '1' then pop else 0 end) as pop_men,
       sum(case when sex = '2' then pop else 0 end) as pop_wom
from Population
group by prefecture;

select emp_name,
       case when count(*) = 1 then max(team)
            when count(*) = 2 then '2개를 겸무'
            when count(*) >= 3 then '3개 이상을 겸무'
       end as team
from employees
group by emp_name;

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

select id,
       max(case when data_type = 'A' then data_1 else null end) as data_1,
       max(case when data_type = 'B' then data_2 else null end) as data_2,
       max(case when data_type = 'B' then data_3 else null end) as data_3
from NonAggTbl
group by id;

create table PriceByAge
(
    product_id varchar(32) not null,
    low_age    integer     not null,
    high_age   integer     not null,
    price      integer     not null,
    primary key (product_id, low_age),
    check (low_age < high_age)
);

INSERT INTO PriceByAge VALUES('제품1',  0  ,  50  ,  2000);
INSERT INTO PriceByAge VALUES('제품1',  51 ,  100 ,  3000);
INSERT INTO PriceByAge VALUES('제품2',  0  ,  100 ,  4200);
INSERT INTO PriceByAge VALUES('제품3',  0  ,  20  ,  500);
INSERT INTO PriceByAge VALUES('제품3',  31 ,  70  ,  800);
INSERT INTO PriceByAge VALUES('제품3',  71 ,  100 ,  1000);
INSERT INTO PriceByAge VALUES('제품4',  0  ,  99  ,  8900);

select * From PriceByAge;

select product_id
from PriceByAge
group by product_id
having SUM(high_age - low_age + 1) = 101;

create table HotelRooms
(
    room_nbr   INTEGER,
    start_date Date,
    end_date   Date,
    PRIMARY KEY (room_nbr, start_date)
);

INSERT INTO HotelRooms VALUES(101, '2008-02-01', '2008-02-06');
INSERT INTO HotelRooms VALUES(101, '2008-02-06', '2008-02-08');
INSERT INTO HotelRooms VALUES(101, '2008-02-10', '2008-02-13');
INSERT INTO HotelRooms VALUES(202, '2008-02-05', '2008-02-08');
INSERT INTO HotelRooms VALUES(202, '2008-02-08', '2008-02-11');
INSERT INTO HotelRooms VALUES(202, '2008-02-11', '2008-02-12');
INSERT INTO HotelRooms VALUES(303, '2008-02-03', '2008-02-17');

select room_nbr,
       sum(end_date - start_date) as working_days
from HotelRooms
group by room_nbr
having sum(end_date - start_date) >= 10;

CREATE TABLE Persons
(name   VARCHAR(8) NOT NULL,
 age    INTEGER NOT NULL,
 height FLOAT NOT NULL,
 weight FLOAT NOT NULL,
 PRIMARY KEY (name));

INSERT INTO Persons VALUES('Anderson',  30,  188,  90);
INSERT INTO Persons VALUES('Adela',    21,  167,  55);
INSERT INTO Persons VALUES('Bates',    87,  158,  48);
INSERT INTO Persons VALUES('Becky',    54,  187,  70);
INSERT INTO Persons VALUES('Bill',    39,  177,  120);
INSERT INTO Persons VALUES('Chris',    90,  175,  48);
INSERT INTO Persons VALUES('Darwin',  12,  160,  55);
INSERT INTO Persons VALUES('Dawson',  25,  182,  90);
INSERT INTO Persons VALUES('Donald',  30,  176,  53);

select SUBSTRING(name, 1, 1) as label,
        count(*)
from Persons
group by substring(name, 1, 1);

select case when age < 20 then '어린이'
            when age between 20 and 69 then '성인'
            when age >= 70 then '노인'
            else null end as age_class,
       count(*)
from Persons
group by case when age < 20 then '어린이'
            when age between 20 and 69 then '성인'
            when age >= 70 then '노인'
            else null end;

select case when weight / POWER(height/100, 2) < 18.5 then '저체중'
            when 18.5 <= weight / POWER(height / 100, 2)
                AND weight / POWER(height / 100, 2) < 25 then '정상'
            when 25 <= weight / POWER(height / 100, 2)  then '과체중'
            else null end as bmi,
       count(*)
from Persons
group by case when weight / POWER(height/100, 2) < 18.5 then '저체중'
            when 18.5 <= weight / POWER(height / 100, 2)
                AND weight / POWER(height / 100, 2) < 25 then '정상'
            when 25 <= weight / POWER(height / 100, 2)  then '과체중'
            else null end;

select name,
       age,
       case when age < 20 then '어린이'
            when age between 20 and 69 then '성인'
            when age >= 70 then '노인'
            else null end as age_class,
       Rank() over (
           partition by case when age < 20 then '어린이'
            when age between 20 and 69 then '성인'
            when age >= 70 then '노인'
            else null end
            order by age
           ) as age_rank_in_class
from Persons
order by age_class, age_rank_in_class;

select * from sales2;

CREATE TABLE Sales
(company CHAR(1) NOT NULL,
 year    INTEGER NOT NULL ,
 sale    INTEGER NOT NULL ,
   CONSTRAINT pk_sales PRIMARY KEY (company, year));

INSERT INTO Sales VALUES ('A', 2002, 50);
INSERT INTO Sales VALUES ('A', 2003, 52);
INSERT INTO Sales VALUES ('A', 2004, 55);
INSERT INTO Sales VALUES ('A', 2007, 55);
INSERT INTO Sales VALUES ('B', 2001, 27);
INSERT INTO Sales VALUES ('B', 2005, 28);
INSERT INTO Sales VALUES ('B', 2006, 28);
INSERT INTO Sales VALUES ('B', 2009, 30);
INSERT INTO Sales VALUES ('C', 2001, 40);
INSERT INTO Sales VALUES ('C', 2005, 39);
INSERT INTO Sales VALUES ('C', 2006, 38);
INSERT INTO Sales VALUES ('C', 2010, 35);

select * From sales;
select * from sales2;

CREATE TABLE Sales2
(company CHAR(1) NOT NULL,
 year    INTEGER NOT NULL ,
 sale    INTEGER NOT NULL ,
 var     CHAR(1) ,
   CONSTRAINT pk_sales2 PRIMARY KEY (company, year));

SELECT company,
       year,
       sale,
        CASE SIGN(sale - MAX(sale) OVER (PARTITION BY company ORDER BY year ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING))
            WHEN 0 THEN '='
            WHEN 1 THEN '+'
            WHEN -1 THEN '-'
            ELSE NULL
        END AS var
FROM sales;

select company,
       year,
       sale,
       max(company)
         over(partition by company
             order by year
             rows between 1 preceding and 1 preceding) as pre_company,
       max(sale)
         over(partition by company
             order by year
             rows between 1 preceding and 1 preceding) as pre_sale
from sales;

select s1.year, s2.sale
from sales s2, Sales s1
where s1.company = s2.company
and s1.year = (select MAX(year)
            from sales s3
            where s1.company = s3.company
            and s1.year > s3.year);

#윈도우 파티션 함수를 이용한 그루핑, case when을 활용한 조건분기, subquery를 통한 데이터 추출

CREATE TABLE PostalCode
(pcode CHAR(7),
 district_name VARCHAR(256),
     CONSTRAINT pk_pcode PRIMARY KEY(pcode));

INSERT INTO PostalCode VALUES ('4130001',  '시즈오카 아타미 이즈미');
INSERT INTO PostalCode VALUES ('4130002',  '시즈오카 아타미 이즈산');
INSERT INTO PostalCode VALUES ('4130103',  '시즈오카 아타미 아지로');
INSERT INTO PostalCode VALUES ('4130041',  '시즈오카 아타미 아오바초');
INSERT INTO PostalCode VALUES ('4103213',  '시즈오카 이즈 아오바네');
INSERT INTO PostalCode VALUES ('4380824',  '시즈오카 이와타 아카');

SELECT pcode,
       district_name
FROM PostalCode
where CASE
          WHEN pcode = '4130033' THEN 0
          WHEN pcode LIKE '413003%' THEN 1
          WHEN pcode LIKE '41300%' THEN 2
          WHEN pcode LIKE '4130%' THEN 3
          WHEN pcode LIKE '413%' THEN 4
          WHEN pcode LIKE '41%' THEN 5
          WHEN pcode LIKE '4%' THEN 6
          else null end =
      (select min(case
                      when pcode = '4130033' then 0
                      when pcode like '413003%' then 1
                      when pcode like '41300%' then 2
                      when pcode like '4130%' then 3
                      when pcode like '413%' then 4
                      when pcode like '41%' then 5
                      when pcode like '4%' then 6
                      else null end
                  ) from PostalCode);

select pcode,
       district_name
from (select pcode,
             district_name,
             CASE
                 WHEN pcode = '4130033' THEN 0
                 WHEN pcode LIKE '413003%' THEN 1
                 WHEN pcode LIKE '41300%' THEN 2
                 WHEN pcode LIKE '4130%' THEN 3
                 WHEN pcode LIKE '413%' THEN 4
                 WHEN pcode LIKE '41%' THEN 5
                 WHEN pcode LIKE '4%' THEN 6
                 else null end                     as hit_cide,
             min(CASE
                     WHEN pcode = '4130033' THEN 0
                     WHEN pcode LIKE '413003%' THEN 1
                     WHEN pcode LIKE '41300%' THEN 2
                     WHEN pcode LIKE '4130%' THEN 3
                     WHEN pcode LIKE '413%' THEN 4
                     WHEN pcode LIKE '41%' THEN 5
                     WHEN pcode LIKE '4%' THEN 6
                     else null end)
                 over (order by CASE
                                    WHEN pcode = '4130033' THEN 0
                                    WHEN pcode LIKE '413003%' THEN 1
                                    WHEN pcode LIKE '41300%' THEN 2
                                    WHEN pcode LIKE '4130%' THEN 3
                                    WHEN pcode LIKE '413%' THEN 4
                                    WHEN pcode LIKE '41%' THEN 5
                                    WHEN pcode LIKE '4%' THEN 6
                                    else null end) as min_code
      from PostalCode) Foo
where hit_cide = min_code;

drop table Employees;

CREATE TABLE Employees
(emp_id CHAR(8),
 emp_name VARCHAR(32),
 dept_id CHAR(2),
     CONSTRAINT pk_emp PRIMARY KEY(emp_id));

CREATE TABLE Departments
(dept_id CHAR(2),
 dept_name VARCHAR(32),
     CONSTRAINT pk_dep PRIMARY KEY(dept_id));

CREATE INDEX idx_dept_id ON Employees(dept_id);

INSERT INTO Employees VALUES('001', '하린',   '10');
INSERT INTO Employees VALUES('002', '한미루', '11');
INSERT INTO Employees VALUES('003', '사라',   '11');
INSERT INTO Employees VALUES('004', '중민',   '12');
INSERT INTO Employees VALUES('005', '웅식',   '12');
INSERT INTO Employees VALUES('006', '주아',   '12');

INSERT INTO Departments VALUES('10', '총무');
INSERT INTO Departments VALUES('11', '인사');
INSERT INTO Departments VALUES('12', '개발');
INSERT INTO Departments VALUES('13', '영업');

select e.emp_id, e.emp_name, e.dept_id, d.dept_name
from Employees e inner join Departments d
on e.dept_id = d.dept_id;

select e.emp_id, e.emp_name, e.dept_id,
       (select d.dept_name
        from Departments d
        where e.dept_id = d.dept_id) as dept_name
from Employees e;

CREATE TABLE Receipts
(cust_id   CHAR(1) NOT NULL,
 seq   INTEGER NOT NULL,
 price   INTEGER NOT NULL,
     PRIMARY KEY (cust_id, seq));

INSERT INTO Receipts VALUES ('A',   1   ,500    );
INSERT INTO Receipts VALUES ('A',   2   ,1000   );
INSERT INTO Receipts VALUES ('A',   3   ,700    );
INSERT INTO Receipts VALUES ('B',   5   ,100    );
INSERT INTO Receipts VALUES ('B',   6   ,5000   );
INSERT INTO Receipts VALUES ('B',   7   ,300    );
INSERT INTO Receipts VALUES ('B',   9   ,200    );
INSERT INTO Receipts VALUES ('B',   12  ,1000   );
INSERT INTO Receipts VALUES ('C',   10  ,600    );
INSERT INTO Receipts VALUES ('C',   20  ,100    );
INSERT INTO Receipts VALUES ('C',   45  ,200    );
INSERT INTO Receipts VALUES ('C',   70  ,50     );
INSERT INTO Receipts VALUES ('D',   3   ,2000   );

select cust_id,
       seq,
       price,
       row_number() over (
           partition by cust_id
           order by seq
           ) as row_weq
from Receipts;

select cust_id,
       sum(case when min_seq = 1 then price else 0 end)
           - sum(case when max_seq = 1 then price else 0 end) as diff
from (select cust_id,
             price,
             row_number() over (partition by cust_id
                 order by seq)      as min_seq,
             row_number() over (partition by cust_id
                 order by seq DESC) as max_seq
      from Receipts) work
where work.min_seq = 1
or work.max_seq = 1
group by cust_id;

select cust_id,
       price,
       row_number() over (partition by cust_id
           order by seq)      as min_seq,
       row_number() over (partition by cust_id
           order by seq DESC) as max_seq
from Receipts;

select * from Receipts;

CREATE TABLE Companies
(co_cd      CHAR(3) NOT NULL,
 district   CHAR(1) NOT NULL,
     CONSTRAINT pk_Companies PRIMARY KEY (co_cd));

INSERT INTO Companies VALUES('001', 'A');
INSERT INTO Companies VALUES('002', 'B');
INSERT INTO Companies VALUES('003', 'C');
INSERT INTO Companies VALUES('004', 'D');


CREATE TABLE Shops
(co_cd      CHAR(3) NOT NULL,
 shop_id    CHAR(3) NOT NULL,
 emp_nbr    INTEGER NOT NULL,
 main_flg   CHAR(1) NOT NULL,
     PRIMARY KEY (co_cd, shop_id));

INSERT INTO Shops VALUES('001', '1',   300,  'Y');
INSERT INTO Shops VALUES('001', '2',   400,  'N');
INSERT INTO Shops VALUES('001', '3',   250,  'Y');
INSERT INTO Shops VALUES('002', '1',   100,  'Y');
INSERT INTO Shops VALUES('002', '2',    20,  'N');
INSERT INTO Shops VALUES('003', '1',   400,  'Y');
INSERT INTO Shops VALUES('003', '2',   500,  'Y');
INSERT INTO Shops VALUES('003', '3',   300,  'N');
INSERT INTO Shops VALUES('003', '4',   200,  'Y');
INSERT INTO Shops VALUES('004', '1',   999,  'Y');

select * from Shops;
select * from Companies;

# 결합을 먼저 수행
select c.co_cd, MAX(c.district) as district,
       sum(emp_nbr) as sum_emp
from Companies c
    inner join shops s
    on c.co_cd = s.co_cd
where main_flg = 'Y'
group by c.co_cd;

# 집약을 먼저 수행
select c.co_cd, c.district, sum_emp
from Companies c
         inner join (select co_cd,
                            sum(emp_nbr) as sum_emp
                     from shops
                     where main_flg = 'Y'
                     group by co_cd) csum
                    on c.co_cd = csum.co_cd;


CREATE TABLE Weights
(student_id CHAR(4) PRIMARY KEY,
 weight     INTEGER);

INSERT INTO Weights VALUES('A100', 50);
INSERT INTO Weights VALUES('A101', 55);
INSERT INTO Weights VALUES('A124', 55);
INSERT INTO Weights VALUES('B343', 60);
INSERT INTO Weights VALUES('B346', 72);
INSERT INTO Weights VALUES('C563', 72);
INSERT INTO Weights VALUES('C345', 72);

select student_id,
       row_number() over (order by student_id) as seq
from Weights;

select student_id,
       (select count(*)
        from Weights w2
        where w2.student_id <= w1.student_id) as seq
from Weights w1;

CREATE TABLE Weights2
(class      INTEGER NOT NULL,
 student_id CHAR(4) NOT NULL,
 weight INTEGER     NOT NULL,
 PRIMARY KEY(class, student_id));

INSERT INTO Weights2 VALUES(1, '100', 50);
INSERT INTO Weights2 VALUES(1, '101', 55);
INSERT INTO Weights2 VALUES(1, '102', 56);
INSERT INTO Weights2 VALUES(2, '100', 60);
INSERT INTO Weights2 VALUES(2, '101', 72);
INSERT INTO Weights2 VALUES(2, '102', 73);
INSERT INTO Weights2 VALUES(2, '103', 73);

select class, student_id,
       row_number() over (order by class, student_id) as seq
from Weights2;

select class, student_id,
       (select count(*)
        from Weights2 w2
        where (w2.class, w2.student_id)
            <= (w1.class, w1.student_id)) as seq
from Weights2 w1;

#윈도우 함수 partition by 있는 경우가 있고 없는 경우가 있다.
select class, student_id,
       row_number() over (partition by class order by student_id) as seq
from Weights2;

select class, student_id,
       (select count(*)
        from Weights2 w2
        where w2.class = w1.class
        and w2.student_id <= w1.student_id) as seq
from Weights2 w1;


CREATE TABLE Weights3
(class      INTEGER NOT NULL,
 student_id CHAR(4) NOT NULL,
 weight INTEGER     NOT NULL,
 seq    INTEGER     NULL,
     PRIMARY KEY(class, student_id));

INSERT INTO Weights3 VALUES(1, '100', 50, NULL);
INSERT INTO Weights3 VALUES(1, '101', 55, NULL);
INSERT INTO Weights3 VALUES(1, '102', 56, NULL);
INSERT INTO Weights3 VALUES(2, '100', 60, NULL);
INSERT INTO Weights3 VALUES(2, '101', 72, NULL);
INSERT INTO Weights3 VALUES(2, '102', 73, NULL);
INSERT INTO Weights3 VALUES(2, '103', 73, NULL);

select * from Weights3;

update Weights3
set seq = (select count(*)
           from Weights3 w2
           where w2.class = Weights3.class
             and w2.student_id <= Weights3.student_id);

select avg(weight) as median
from (select weight,
             row_number() over (order by weight asc, student_id asc)   as hi,
             row_number() over (order by weight desc, student_id desc) as lo
      from Weights) tmp
where hi in (lo, lo + 1, lo - 1);

CREATE TABLE Numbers( num INTEGER PRIMARY KEY);

INSERT INTO Numbers VALUES(1);
INSERT INTO Numbers VALUES(3);
INSERT INTO Numbers VALUES(4);
INSERT INTO Numbers VALUES(7);
INSERT INTO Numbers VALUES(8);
INSERT INTO Numbers VALUES(9);
INSERT INTO Numbers VALUES(12);

select * from Numbers;

select num,
       max(num)
        over(order by num
            rows between 1 following
            and 1 following) as next_num
from Numbers;

select num + 1          as gap_start,
       '~',
       (num + diff - 1) as gap_end
from (select num,
             max(num)
                 over (order by num
                     rows between 1 following
                         and 1 following) - num
      from Numbers) tmp(num, diff)
where diff <> 1;



select min(num) as low,
       '~',
       max(num) as high,
       gp
from (select n1.num,
       count(n2.num) - n1.num
from Numbers n1 inner join Numbers n2
on n2.num <= n1.num
group by n1.num) N(num, gp)
group by gp;

CREATE TABLE OmitTbl
(keycol CHAR(8) NOT NULL,
 seq    INTEGER NOT NULL,
 val    INTEGER ,
  CONSTRAINT pk_OmitTbl PRIMARY KEY (keycol, seq));

INSERT INTO OmitTbl VALUES ('A', 1, 50);
INSERT INTO OmitTbl VALUES ('A', 2, NULL);
INSERT INTO OmitTbl VALUES ('A', 3, NULL);
INSERT INTO OmitTbl VALUES ('A', 4, 70);
INSERT INTO OmitTbl VALUES ('A', 5, NULL);
INSERT INTO OmitTbl VALUES ('A', 6, 900);
INSERT INTO OmitTbl VALUES ('B', 1, 10);
INSERT INTO OmitTbl VALUES ('B', 2, 20);
INSERT INTO OmitTbl VALUES ('B', 3, NULL);
INSERT INTO OmitTbl VALUES ('B', 4, 3);
INSERT INTO OmitTbl VALUES ('B', 5, NULL);
INSERT INTO OmitTbl VALUES ('B', 6, NULL);

select * from OmitTbl;

#1. 같은 keycol 가짐 2. 자신보다 작은 seq를 가짐 3. val이 NULL이 아님
update OmitTbl
set val = (
select val
from OmitTbl ot1
where ot1.keycol = OmitTbl.keycol
and ot1.seq = (select max(seq)
               from OmitTbl ot2
               where ot2.keycol = OmitTbl.keycol
                 and ot2.seq < OmitTbl.seq
                 and ot2.val is not null))
where val is null;





































































































































































































































































































































