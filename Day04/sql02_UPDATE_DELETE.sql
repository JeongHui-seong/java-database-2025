/*
 * UPDATE/DETELE
 * 데이터 변경/데이터 삭제
 * */
CREATE TABLE professor_new
AS
SELECT * FROM professor;

-- 삭제
SELECT COUNT(*) FROM PROFESSOR_NEW;
SELECT * FROM PROFESSOR_NEW;

DELETE FROM PROFESSOR_NEW
 WHERE PROFNO = 1001;

-- 삭제시 WHERE절 빼는 것은 극히 주의
DELETE FROM PROFESSOR_NEW; -- TRUNCATE와 동일하나 테이블 초기화는 없음

SET TRANSACTION READ WRITE; -- 안써도 무방

INSERT INTO PROFESSOR_NEW 
SELECT * FROM PROFESSOR;

-- 변경
-- PROFNO 4002인 수잔 서렌든의 아이디를 기존 Sarandon에서 SusanS로, 급여를 330에서 350으로 올림
UPDATE professor_new SET
	   ID = 'SusanS'
	 , PAY = 350
 WHERE profno = 4002;

/*
 * 트랜잭션, COMMIT, ROLLBACK
 * */
UPDATE professor_new SET
	   ID = 'SusanS'
	 , PAY = 350;

ROLLBACK; -- 원상복구, 트랜잭션은 종료안됨
COMMIT; -- 확정짓고 트랜잭션이 종료

DROP TABLE PROFESSOR_NEW;