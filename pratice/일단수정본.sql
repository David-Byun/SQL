CREATE TABLE DEPT (
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(30) NOT NULL,
    job VARCHAR2(20) NOT NULL,
    workload VARCHAR2(20) NOT NULL,
    related_cert NUMBER NOT NULL unique,
    FOREIGN KEY (related_cert) REFERENCES CERTIFICATE(cert_num)
)

CREATE TABLE CERTIFICATE (
    cert_num NUMBER Primary Key ,
    cert_title VARCHAR2(25)
)

CREATE TABLE EMP (
	emp_num NUMBER PRIMARY KEY,
	name VARCHAR2(20) NOT NULL,
	rank VARCHAR2(20) NOT NULL,
	job VARCHAR2(20) NOT NULL,
	move_hope VARCHAR2(5) NOT NULL,
	cert_num NUMBER NOT NULL,
	department_id NUMBER NOT NULL,
	FOREIGN KEY (department_id) REFERENCES DEPT(department_id),
	FOREIGN KEY (cert_num) REFERENCES CERTIFICATE(cert_num)
)

INSERT INTO DEPT(department_id, department_name, job, workload, related_cert) VALUES (200,'영업점', '-', '-', 0);
INSERT INTO DEPT(department_id, department_name, job, workload, related_cert) VALUES (201,'개인여신부', '개인여신', '상', 301);
INSERT INTO DEPT(department_id, department_name, job, workload, related_cert) VALUES (202,'기업상품부', '기업여신', '상', 302);
INSERT INTO DEPT(department_id, department_name, job, workload, related_cert) VALUES (203,'브랜드전략부', '개인', '중', 303);
INSERT INTO DEPT(department_id, department_name, job, workload, related_cert) VALUES (204,'안전관리부', '개인', '하', 304);
INSERT INTO DEPT(department_id, department_name, job, workload, related_cert) VALUES (205,'연금기획부', '퇴직연금', '상', 305);
INSERT INTO DEPT(department_id, department_name, job, workload, related_cert) VALUES (206,'외환업무부', '외환', '상', 306);
INSERT INTO DEPT(department_id, department_name, job, workload, related_cert) VALUES (207,'직원만족부', '개인', '중', 307);
INSERT INTO DEPT(department_id, department_name, job, workload, related_cert) VALUES (208,'코어뱅킹플랫폼부', 'IT', '상', 308);
INSERT INTO DEPT(department_id, department_name, job, workload, related_cert) VALUES (209,'ESG기획부', '개인', '하', 309);

INSERT INTO CERTIFICATE(cert_num, cert_title) VALUES (0,'자격증없음');
INSERT INTO CERTIFICATE(cert_num, cert_title) VALUES (301,'여신심사역');
INSERT INTO CERTIFICATE(cert_num, cert_title) VALUES (302,'신용분석사');
INSERT INTO CERTIFICATE(cert_num, cert_title) VALUES (303,'구글 애널리틱스');
INSERT INTO CERTIFICATE(cert_num, cert_title) VALUES (304,'산업안전기사');
INSERT INTO CERTIFICATE(cert_num, cert_title) VALUES (305,'은퇴설계자격증');
INSERT INTO CERTIFICATE(cert_num, cert_title) VALUES (306,'CDCS');
INSERT INTO CERTIFICATE(cert_num, cert_title) VALUES (307,'노무사');
INSERT INTO CERTIFICATE(cert_num, cert_title) VALUES (308,'정보처리기사');
INSERT INTO CERTIFICATE(cert_num, cert_title) VALUES (309,'ESG 전문가');
