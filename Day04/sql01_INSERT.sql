/*
 * DML중 SELECT 이외
 * INSERT, UPDATE, DELETE
 * */
-- INSERT
SELECT *
  FROM new_table;

-- INSERT QUERY 기본
INSERT INTO new_table (NO, name, jumin, birth, salary)
VALUES (1, '홍길동', '810205-1825697', '1981-02-05', 5000);

-- 테이블 컬럼리스트와 동일한 순서, 동일한 값을 넣을 때
-- 단, 컬럼리스트와 순서도 다르고, 값리스트 갯수도 다르면 컬럼리스트 생략 불가
INSERT INTO new_table
VALUES (2, '홍길동', '810205-1825697', '1981-02-05', 5000);

-- 컬럼리스트 순서와 갯수가 다를 때는 반드시 컬림리스트를 적어줘야함
INSERT INTO new_table (JUMIN, NAME, NO)
VALUES ('810205-1234567', '홍길길', 3);

-- 값이 뭔지 모를 때는 NULL로 삽입
INSERT INTO NEW_TABLE
VALUES (4, '홍길태', '830105-7894561', NULL, null);

-- 한 테이블에 있는 데이터를 모두 옮기면서 새로운 테이블 생성
-- PK는 복사가 안됨.
CREATE TABLE professor_new
AS
 SELECT * FROM professor;

SELECT * FROM professor_new;

-- 만들어진 테이블에 데이터 한꺼번에 옮기기
INSERT INTO PROFESSOR_NEW 
SELECT * FROM PROFESSOR;

-- 새로 만들어진 테이블 PROFESSOR_NEW 데이터를 삽입 테스트
INSERT INTO professor_new (PROFNO, NAME, ID, POSITION, PAY, HIREDATE)
VALUES (4008, 'Tom Cruise', 'Cruise', 'instructor', '300', '2025-03-14');

-- PROFESSOR_NEW는 PK가 없기 때문에 같은 값이 들어감
INSERT INTO professor_new (PROFNO, NAME, ID, POSITION, PAY, HIREDATE)
VALUES (4008, 'Tom Holland', 'Holland', 'instructor', '310', '2025-03-14');

-- 대량의 데이터를 삽입
INSERT ALL
	INTO NEW_TABLE VALUES (5, '홍길가', '810205-1825697', '1981-02-05', 5000)
	INTO NEW_TABLE VALUES (6, '홍길나', '810205-1825697', '1981-02-05', 5000)
	INTO NEW_TABLE VALUES (7, '홍길다', '810205-1825697', '1981-02-05', 5000)
	INTO NEW_TABLE VALUES (8, '홍길라', '810205-1825697', '1981-02-05', 5000)
	INTO NEW_TABLE VALUES (9, '홍길마', '810205-1825697', '1981-02-05', 5000)
SELECT * FROM DUAL;

SELECT * FROM NEW_TABLE;

