CREATE TABLE Member
(
    member_id   INT              AUTO_INCREMENT PRIMARY KEY,
    email       VARCHAR(45)   ,
    name        VARCHAR(15)    ,
    password    VARCHAR(150)   ,
    tel         VARCHAR(15)    ,
    birth       VARCHAR(15)   ,
    regi_date   DATE          ,
    valid       TINYINT(1)
);


CREATE TABLE Review
(
    review_id   INT             NOT NULL    AUTO_INCREMENT PRIMARY KEY,
    member_id   INT             NOT NULL,
    item_id     INT             NOT NULL,
    type        TINYINT(1)      NULL,
    title       VARCHAR(15)     NOT NULL,
    rdate       DATE            NOT NULL,
    udate       DATE            NULL,
    content     VARCHAR(1000)   NULL
);

CREATE TABLE Order
(
    order_id    INT             NOT NULL    AUTO_INCREMENT PRIMARY KEY,
    member_id   INT             NOT NULL,
    item_id     INT             NOT NULL,
    price       INT             NULL,
    rdate       DATE            NOT NULL,
    valid       TINYINT(1)      NOT NULL
);

CREATE TABLE OrderDetail
(
    detail_id   INT   NOT NULL    AUTO_INCREMENT PRIMARY KEY,
    item_id     INT   NOT NULL,
    order_id    INT   NOT NULL,
    cnt         INT   NOT NULL
);

CREATE TABLE Cart
(
    cart_id     INT   NOT NULL    AUTO_INCREMENT PRIMARY KEY,
    item_id     INT   NOT NULL,
    member_id   INT   NOT NULL,
    cnt         INT   NOT NULL,
    rdate       DATE NULL,
    udate       DATE NULL
);