create table score (
    student_id int(100) auto_increment primary key,
    student varchar(10),
    kor int(100),
    eng int(100),
    math int(100)
);


select * from score;

insert into score (student, kor, eng, math) values ('철수', 100, 80, 90);
insert into score (student, kor, eng, math) values ('영희', 60, 70, 90);
insert into score (student, kor, eng, math) values ('가이', 90, 80, 70);

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

select * from Weights;

select student_id, weight,
        row_number() over (order by student_id) as seq
from Weights;

select student_id,


select student_id,
(select count(*)
    from weights w2
    where w2.student_id <= w1.student_id) as seq
from Weights w1;

select *
from Weights w1, Weights w2
where w2.student_id <= w1.student_id

select student_id,
(select count(*)
    from Weights w2
    where w2.weight <= w1.student_id) as seq
from Weights w1

CREATE TABLE Weights2
(class      INTEGER NOT NULL,
 student_id CHAR(4) NOT NULL,
 weight INTEGER     NOT NULL,
 PRIMARY KEY(class, student_id));

select * from weights2;

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
        from weights2 w2
        where (w2.class, w2.student_id)
        <=(w1.class, w1.student_id)) as seq
from Weights2 w1;

select class, student_id,
       row_number() over (partition by class order by student_id) as seq
from Weights2;

테이블을 그룹으로 나누고 그룹마다 내부 레코드에 순번을 붙이는 방법

select class, student_id,
      (Select count(*)
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
               from weights3 w2
               where w2.class = weights3.class
               and w2.student_id <= Weights3.student_id);

update Weights3
    set seq = (select seq
                from (select seq, student_id,
                      row_number() over (partition by class
                                            order by student_id) as seq
                      from Weights3) seqtb1
                where Weights3.class =seqtb1.class

중앙값 구하기 (절차 지향형) : 양쪽 끝에서 레코드 하나씩 세어 중간을 찾음
                                                                                                                                                                                         ]
select avg(weight) as median
from
(select weight,
        row_number() over (order by weight asc, student_id asc) as hi,
        row_number() over (order by weight desc, student_id desc) as lo
from weights) tmp;
where hi in (lo, lo+1, lo-1);

select weight,
       2 * row_number() over (order by weight) - count(*) over() as diff
from Weights;


select count(*) over()
from Weights;

CREATE TABLE Numbers( num INTEGER PRIMARY KEY);

INSERT INTO Numbers VALUES(1);
INSERT INTO Numbers VALUES(3);
INSERT INTO Numbers VALUES(4);
INSERT INTO Numbers VALUES(7);
INSERT INTO Numbers VALUES(8);
INSERT INTO Numbers VALUES(9);
INSERT INTO Numbers VALUES(12);

select * from numbers;

윈도우 함수를 이용할 때는 over 로 진행하기 때문에 집합연산자로 묶어줘야함(max, min 혹은 기타 등등)

select num,
        max(num)
        over(order by num
                rows between 1 following and 1 following) as next_num
from numbers;

select min(num) as low,
       '~',
       max(num) as high
from numbers


select Min(num) as low,
       '~',
       max(num) as high
from
(select n1.num, count(n2.num) - n1.num
from Numbers n1 inner join numbers n2
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

























