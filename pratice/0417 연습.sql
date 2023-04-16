select * from stocks2;

select * from stocks;

CREATE TABLE Stocks
(brand      VARCHAR(8) NOT NULL,
 sale_date  DATE       NOT NULL,
 price      INTEGER    NOT NULL,
    CONSTRAINT pk_Stocks PRIMARY KEY (brand, sale_date));

INSERT INTO Stocks VALUES ('A철강', '2008-07-01', 1000);
INSERT INTO Stocks VALUES ('A철강', '2008-07-04', 1200);
INSERT INTO Stocks VALUES ('A철강', '2008-08-12', 800);
INSERT INTO Stocks VALUES ('B상사', '2008-06-04', 3000);
INSERT INTO Stocks VALUES ('B상사', '2008-09-11', 3000);
INSERT INTO Stocks VALUES ('C전기', '2008-07-01', 9000);
INSERT INTO Stocks VALUES ('D산업', '2008-06-04', 5000);
INSERT INTO Stocks VALUES ('D산업', '2008-06-05', 5000);
INSERT INTO Stocks VALUES ('D산업', '2008-06-06', 4800);
INSERT INTO Stocks VALUES ('D산업', '2008-12-01', 5100);


■ 코드 9.16 갱신 대상 주가 테이블의 정의
CREATE TABLE Stocks2
(brand      VARCHAR(8) NOT NULL,
 sale_date  DATE       NOT NULL,
 price      INTEGER    NOT NULL,
 trend      CHAR(3)    ,
    CONSTRAINT pk_Stocks2 PRIMARY KEY (brand, sale_date));


insert into Stocks2
select brand, sale_date, price,
case sign(price -
(select price
from stocks s1
where brand = stocks.brand
and sale_date = (
    select MAX(sale_date)
    from stocks s2
    where brand = stocks.brand
    and sale_date < stocks.sale_date)))
when -1 then '-'
when 0 then ''
when 1 then '+'
else null end
from stocks;

select max(sale_date)
from stocks;

select * from stocks;

INSERT INTO stocks2
SELECT brand, sale_date, price,
       CASE SIGN(price -
                 MAX(price) OVER (PARTITION BY brand
                                  ORDER BY sale_date
                                  ROWS BETWEEN 1 PRECEDING
                                  AND 1 PRECEDING))
       WHEN -1 THEN '-'
       WHEN 0 THEN ''
       WHEN 1 THEN '+'
       ELSE NULL END
FROM Stocks S2;

CREATE TABLE Orders
(order_id INTEGER NOT NULL,
order_shop VARCHAR(32) NOT NULL,
order_name VARCHAR(32) NOT NULL,
order_date DATE,
PRIMARY KEY (order_id));

select * from Orders;

INSERT INTO Orders VALUES (10000, '서울', '윤인성',     '2011/8/22');
INSERT INTO Orders VALUES (10001, '인천', '연하진',     '2011/9/1');
INSERT INTO Orders VALUES (10002, '인천', '패밀리마트', '2011/9/20');
INSERT INTO Orders VALUES (10003, '부천', '한빛미디어', '2011/8/5');
INSERT INTO Orders VALUES (10004, '수원', '동네슈퍼',   '2011/8/22');
INSERT INTO Orders VALUES (10005, '성남', '야근카페',   '2011/8/29');


CREATE TABLE OrderReceipts
( order_id INTEGER NOT NULL PRIMARY KEY ,
　order_receipt_id INTEGER NOT NULL ,
　item_group VARCHAR(32) NOT NULL,
　delivery_date DATE NOT NULL);

select * from OrderReceipts;

INSERT INTO OrderReceipts VALUES (10000, 1, '식기',         '2011/8/24');
INSERT INTO OrderReceipts VALUES (10000, 2, '과자',         '2011/8/25');
INSERT INTO OrderReceipts VALUES (10000, 3, '소고기',       '2011/8/26');
INSERT INTO OrderReceipts VALUES (10001, 1, '어패류',       '2011/9/4');
INSERT INTO OrderReceipts VALUES (10002, 1, '과자',         '2011/9/22');
INSERT INTO OrderReceipts VALUES (10002, 2, '조미료 세트',  '2011/9/22');
INSERT INTO OrderReceipts VALUES (10003, 1, '쌀',           '2011/8/6');
INSERT INTO OrderReceipts VALUES (10003, 2, '소고기',       '2011/8/10');
INSERT INTO OrderReceipts VALUES (10003, 3, '식기',         '2011/8/10');
INSERT INTO OrderReceipts VALUES (10004, 1, '야채',         '2011/8/23');
INSERT INTO OrderReceipts VALUES (10005, 1, '음료수',       '2011/8/30');
INSERT INTO OrderReceipts VALUES (10005, 2, '과자',          '2011/8/30');

SELECT O.order_id
        , O.order_name
        , ORC.　delivery_date - O.order_date AS diff_days
FROM Orders O
    INNER JOIN OrderReceipts ORC
    on O.order_date = ORC.　delivery_date
WHERE ORC.　delivery_date - O.order_date >= 3;

select O.order_id
        , O.order_name
FROM Orders O
INNER JOIN OrderReceipts ORC
    on O.order_id = ORC.order_id
WHERE ORC.delivery_date - O.order_date >= 3;

SELECT O.order_id
        , MAX(O.order_name)
        , MAX(R.delivery_date - O.order_date) AS max_diff_days
    FROM Orders O
    INNER JOIN OrderReceipts R
    ON O.order_id = R.order_id
WHERE R.　delivery_date - O.order_date >= 3
GROUP BY O.order_id;

1:1 매칭이라는 가정하에 MAX 함수로 해당 인원을 선택할 수 있다.
본래 의미인 MAX를 의미하는 것이 아닌 GROUP BY 에도 정의되어 있지 않고 상수도 아니므로 MAX 집계함수를 통해서 해당 컬럼을 가져온다.

SELECT O.order_id
        , MAX(O.order_name) AS order_name,
        , MAX(O.order_date) AS order_date
        , COUNT(*) AS item_count
FROM Orders O
INNER JOIN OrderReceipts ORC
ON ORC.order_id = O.order_id
GROUP BY O.order_id;

SELECT O.order_id
        , O.order_name
        , O.order_date
        , COUNT(*) OVER (PARTITION BY O.order_id) AS item_count
FROM Orders O
INNER JOIN OrderReceipts R
    on O.order_id = R.order_id;



































