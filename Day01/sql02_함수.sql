/* 내장함수
 * */

/* 문자 (열) 함수 */

-- INITCAP() 단어의 첫 글자를 대문자로
SELECT initcap('hello oracle') AS "result"
  FROM dual; -- 실제하지 않는 테이블(Oracle만)
  
-- LOWER() 모든 글자를 소문자로 , UPPER() 모든 글자를 대문자로
SELECT lower(first_name) AS "first_name"
     , upper(last_name) AS "last_name"
     , first_name AS "Original first_name"
  FROM employees;

-- LENGTH() / LENGTHB() 함수
SELECT LENGTH('Hello oracle')	-- 글자 길이 12
     , LENGTHB('Hello oracle')	-- 12bytes
     , LENGTH('반가워요 오라클')	-- 글자 길이 8
     , LENGTHB('반가워요 오라클')	-- 22bytes, 한글 7자 * 3bytes = 21 + 공백 1byte
     , ascii('A')
     , ascii('a')
     , ascii('가')
  FROM dual;

-- CONCAT()
SELECT concat(concat(first_name, ' '),last_name) AS "full_name"
  FROM employees