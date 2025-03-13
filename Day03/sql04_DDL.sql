/*
 * DDL - 데이터조작언어
 * CREATE, ALTER, DROP, TRUNCATE...
 * 객체를 생성하고, 수정, 삭제, 데이터 초기화...
 * */

-- no, name, birth 컬럼의 테이블 new_table 생성
-- create table new_table ();
CREATE TABLE new_table (
	NO		number(5,0) PRIMARY KEY,-- PK는 지정하는게 기본
	name	varchar2(20) NOT NULL,
	jumin	char(14),
	birth	DATE
);

-- 삭제
DROP TABLE NEW_table;

-- 기본값을 설정하면서 테이블 생성
CREATE TABLE new_table (
	NO		number(5,0)		PRIMARY KEY,-- PK는 지정하는게 기본
	name	varchar2(20)	NOT NULL,
	jumin	char(14),
	birth	DATE,
	salary	number(7,0)		DEFAULT 0 -- 아무 값도 넣지 않고 INSERT하면 NULL을 0으로 대체
);

-- 테이블컬럼에 주석추가
COMMENT ON COLUMN new_table.name IS '사원이름';

-- 기본키가 두개인 테이블 생성
CREATE TABLE doublekeytbl (
	id		number(5,0),
	code	char(4),
	jumin	char(14) UNIQUE,
	name	varchar(20) NOT NULL,
	CONSTRAINT PK_DK PRIMARY KEY(id, code)
);

-- new_member 부모테이블과 new_board 자식테이블 간의 관계가 성립된 테이블 생성
CREATE TABLE new_member (
	idx	 NUMBER PRIMARY KEY,
	name varchar2(20) NOT NULL,
	id	 varchar2(20) NOT NULL,
	pass varchar2(256) NOT NULL
);

-- new_board는 new_member의 pk인 idx를 외래키로 사용
CREATE TABLE new_board (
	bidx NUMBER PRIMARY KEY,
	title varchar2(125) NOT NULL,
	contents LONG NOT NULL,
	reg_date DATE DEFAULT sysdate,
	count number(6,0) DEFAULT 0,
	midx NUMBER NOT NULL,
	CONSTRAINT fk_memberidx FOREIGN KEY (midx) REFERENCES NEW_member (idx)
);

-- ALTER 기존 테이블을 수정할 때 사용
ALTER TABLE new_table ADD (address varchar2(200));

-- ALTER로 기존 테이블에 전화번호 컬럼 추가
-- 이미 데이터가 존재하는 테이블에 NOT NULL 컬럼은 추가 불가
ALTER TABLE NEW_table ADD (tel varchar2(20) NOT null); -- 불가

-- 컬럼 수정 varchar2(200) -> varchar2(100)
ALTER TABLE new_table modify (address varchar2(100));

-- DROP 테이블 삭제
-- purge 휴지통으로 보냄
DROP TABLE NEW_TABLE purge;

-- TRUNCATE 테이블 초기화
-- id(자동으로 증가하는 형태) 1,2,3,4,5...
TRUNCATE TABLE new_table;