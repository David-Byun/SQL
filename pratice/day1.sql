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









































































































































