CREATE TABLE REVIEW (
    review_id   INT              NOT NULL,
    member_id   INT              NOT NULL,
    item_id     INT              NOT NULL,
    type        INT,
    title       VARCHAR2(15)     NOT NULL,
    rdate       DATE             NOT NULL,
    udate       DATE,
    content     VARCHAR2(1000)   NULL
);

CREATE TABLE MEMBER (
    member_id   INT             NOT NULL,
    email       VARCHAR2(45)     NOT NULL,
    name        VARCHAR2(15)     NOT NULL,
    password    VARCHAR2(150)    NOT NULL,
    tel         VARCHAR2(15),
    birth       VARCHAR2(15),
    regi_date   DATE            NOT NULL,
    valid       INT             NOT NULL
);

CREATE TABLE ORDER_TB (
    order_id    INT             NOT NULL,
    member_id   INT             NOT NULL,
    item_id     INT             NOT NULL,
    price       INT,
    rdate       DATE            NOT NULL,
    valid       INT             NOT NULL
);

CREATE TABLE ORDER_DETAIL (
    detail_id   INT   NOT NULL,
    item_id     INT   NOT NULL,
    order_id    INT   NOT NULL,
    cnt         INT   NOT NULL
);

CREATE TABLE CART (
    cart_id     INT     NOT NULL,
    item_id     INT     NOT NULL,
    member_id   INT     NOT NULL,
    cnt         INT     NOT NULL,
    rdate       DATE    NOT NULL,
    udate       DATE
);

CREATE TABLE ITEM (
    item_id     INT             NOT NULL,
    item_name   VARCHAR2(150)   NOT NULL,
    img         VARCHAR2(600)   NOT NULL,
    content     VARCHAR2(1000)  NOT NULL,
    price       INT             NOT NULL,
    rdate       DATE            NOT NULL,
    udate       DATE
);

/* PRIMARY KEY 제약 조건 추가 쿼리 */
ALTER TABLE REVIEW ADD CONSTRAINT review_primary PRIMARY KEY (review_id);
ALTER TABLE MEMBER ADD CONSTRAINT member_primary PRIMARY KEY (member_id);
ALTER TABLE ORDER_TB ADD CONSTRAINT order_primary PRIMARY KEY (order_id);
ALTER TABLE ORDER_DETAIL ADD CONSTRAINT order_detail_primary PRIMARY KEY (detail_id);
ALTER TABLE CART ADD CONSTRAINT cart_primary PRIMARY KEY (cart_id);
ALTER TABLE ITEM ADD CONSTRAINT item_primary PRIMARY KEY (item_id);

/* FOREIGN KEY 제약 조건 추가 쿼리 */

/* CART FOREIGN KEY 쿼리 */
ALTER TABLE CART ADD CONSTRAINT cart_item_foreign FOREIGN KEY (item_id) REFERENCES ITEM(item_id);
ALTER TABLE CART ADD CONSTRAINT cart_member_foreign FOREIGN KEY (member_id) REFERENCES MEMBER(member_id);

/* REVIEW FOREIGN KEY 쿼리 */
ALTER TABLE REVIEW ADD CONSTRAINT review_item_foreign FOREIGN KEY (item_id) REFERENCES ITEM(item_id);
ALTER TABLE REVIEW ADD CONSTRAINT review_member_foreign FOREIGN KEY (member_id) REFERENCES MEMBER(member_id);

/* ORDER_TB FOREIGN KEY 쿼리 */
ALTER TABLE ORDER_TB ADD CONSTRAINT order_item_foreign FOREIGN KEY (item_id) REFERENCES ITEM(item_id);
ALTER TABLE ORDER_TB ADD CONSTRAINT order_member_foreign FOREIGN KEY (member_id) REFERENCES MEMBER(member_id);

/* ORDER_DETAIL FOREIGN KEY 쿼리 */
ALTER TABLE ORDER_DETAIL ADD CONSTRAINT order_detail_item_foreign FOREIGN KEY (item_id) REFERENCES ITEM(item_id);
ALTER TABLE ORDER_DETAIL ADD CONSTRAINT order_detail_order_foreign FOREIGN KEY (order_id) REFERENCES ORDER_TB(order_id);


/* ORDER SEQUENCE 쿼리 */
CREATE SEQUENCE order_seq
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;
/* 1부터 시작하려면 .currval 사용해야 하는데 아래 쿼리 이후 사용해야 에러 발생 안함 */
select order_seq.nextval from dual;

/* MEMBER SEQUENCE 쿼리 */
CREATE SEQUENCE member_seq
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;
/* 1부터 시작하려면 .currval 사용해야 하는데 아래 쿼리 이후 사용해야 에러 발생 안함 */
select member_seq.nextval from dual;

/* REVIEW SEQUENCE 쿼리 */
CREATE SEQUENCE review_seq
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;
/* 1부터 시작하려면 .currval 사용해야 하는데 아래 쿼리 이후 사용해야 에러 발생 안함 */
select review_seq.nextval from dual;

/* CART SEQUENCE 쿼리 */
CREATE SEQUENCE cart_seq
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;
/* 1부터 시작하려면 .currval 사용해야 하는데 아래 쿼리 이후 사용해야 에러 발생 안함 */
select cart_seq.nextval from dual;

/* ITEM SEQUENCE 쿼리 */
CREATE SEQUENCE item_seq
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;
/* 1부터 시작하려면 .currval 사용해야 하는데 아래 쿼리 이후 사용해야 에러 발생 안함 */
select item_seq.nextval from dual;

/* ORDER_DETAIL SEQUENCE 쿼리 */
CREATE SEQUENCE order_detail_seq
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;
/* 1부터 시작하려면 .currval 사용해야 하는데 아래 쿼리 이후 사용해야 에러 발생 안함 */
select order_detail_seq.nextval from dual;

/* ORDER_TB INSERT 쿼리 */
INSERT INTO ORDER_TB VALUES (order_seq.currval, 1, 1, 2000, SYSDATE, 1);
INSERT INTO ORDER_TB VALUES (order_seq.nextval, 1, 2, 3000, SYSDATE, 1);
INSERT INTO ORDER_TB VALUES (order_seq.nextval, 1, 3, 4000, SYSDATE, 1);
INSERT INTO ORDER_TB VALUES (order_seq.nextval, 2, 1, 5000, SYSDATE, 1);
INSERT INTO ORDER_TB VALUES (order_seq.nextval, 2, 2, 2000, SYSDATE, 1);
INSERT INTO ORDER_TB VALUES (order_seq.nextval, 2, 3, 3000, SYSDATE, 1);
INSERT INTO ORDER_TB VALUES (order_seq.nextval, 3, 1, 4000, SYSDATE, 1);
INSERT INTO ORDER_TB VALUES (order_seq.nextval, 3, 2, 5000, SYSDATE, 1);

/* ORDER_DETAIL INSERT 쿼리 */
INSERT INTO ORDER_DETAIL VALUES (order_detail_seq.currval, 1, 1, 1);
INSERT INTO ORDER_DETAIL VALUES (order_detail_seq.nextval, 1, 1, 2);
INSERT INTO ORDER_DETAIL VALUES (order_detail_seq.nextval, 1, 1, 2);
INSERT INTO ORDER_DETAIL VALUES (order_detail_seq.nextval, 2, 2, 1);
INSERT INTO ORDER_DETAIL VALUES (order_detail_seq.nextval, 2, 2, 2);
INSERT INTO ORDER_DETAIL VALUES (order_detail_seq.nextval, 2, 3, 2);

/* 테이블 꼬였을시 드랍 쿼리 */
DROP TABLE REVIEW;
DROP TABLE MEMBER;
DROP TABLE ORDER_TB;
DROP TABLE ORDER_DETAIL;
DROP TABLE CART;
DROP TABLE ITEM;