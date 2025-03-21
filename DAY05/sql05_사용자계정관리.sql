/*
 * 사용자 생성, 기존 사용자 사용해제, 권한 주기
 * */

-- HR 계정 잠금해제
ALTER USER hr ACCOUNT UNLOCK;
ALTER USER hr IDENTIFIED BY 12345;

COMMIT;

SELECT *
  FROM EMPLOYEES;

-- PRIVILEGES 권한
-- CREATE SESSION - 접속 권한
-- CREATE TABLE, ALTER ANY TABLE, DROP ANY TABLE
-- 권한은 하나하나 다 부여해야함

-- SCOTT 계정 잠금해제. 계정이 없을 수도 있음
-- ALTER USER SCOTT ACCOUNT UNLOCK;

-- SCOTT은 CREATE SESSION 권한이 없음, LOGON DENIED
-- SCOTT에게 접속권한 부여.
-- GRANT CREATE SESSION TO SCOTT;

SELECT *
  FROM JOBS;

CREATE VIEW JOBS_VIEW
AS
 SELECT *
   FROM JOBS;

-- HR계정에 어떤 권한이 있는지 조회
SELECT *
  FROM USER_TAB_PRIVS;

-- HR로 테이블 생성
CREATE TABLE TEST (
	ID NUMBER PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL
);

-- ROLE(역할) 관리
-- 여러 권한을 묶어놓은 개념
-- ROLE 확인
-- CONNECT - DB접속 및 테이블 생성 조회 권한
-- RESOURCE - PL/SQL 사용권한
-- DBA - 모든 시스템 권한
-- EXP_FULL_DATABASE - 데이터베이스 익스토프 권한
SELECT * FROM USER_ROLE_PRIVS;

SELECT * FROM DBA_ROLE_PRIVS;

-- HR에게 DBA역할 부여
GRANT DBA TO HR;

SELECT * FROM SAMPLEUSER.MEMBER;

-- HR에게 DBA역할 권한 해제
REVOKE DBA FROM HR;
