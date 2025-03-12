/* 단일행 함수 */

SELECT concat('Hello', 'Oracle') -- 한행한열만 출력되는 값을 = 스칼라(Scalar)값
  FROM dual;

-- 인덱스가 1부터 시작, 일반 프로그래밍 언어의 배열이 0부터 시작하는 것과의 차이
-- SUBSTR(변환할 값, 인덱스, 길이) - 파이썬 substring() 함수와 동일
-- -인덱스 - 뒤에서부터 위치
SELECT substr(email, 1, 2)	-- 진짜 많이 씀
     , substr(email, -2, 2)
     , email
  FROM employees;

-- 전화번호 자를 때, 주민번호 자를 때 SUBSTR() 활용

-- INSTR(체크할 문자열, 찾는 글자, 시작 위치, 몇 번째)
SELECT '010-9999-8888'
     , instr('010-9999-8888', '-', 5, 1)
  FROM dual;

-- LPAD(문자열, 자리수, 채울 문자), RPAD(문자열, 자리수, 채울 문자)
-- 2025-3-12 -> 2025-03-12
-- 0000100 규칙, 101 -> 0000101
SELECT lpad('100',7,'0')	-- 진짜 많이 씀
     , rpad('ABC',7,'-')	-- 잘 안씀
  FROM dual;

-- TRIM() 함수 트리플 == 파이썬 STRIP() 함수와 동일
-- LTRIM(), RTRIM(), TRIM()
SELECT '<<<' || '     Hello Oracle     ' || '>>>'
     , '<<<' || ltrim('     Hello Oracle     ') || '>>>'
     , '<<<' || rtrim('     Hello Oracle     ') || '>>>'
     , '<<<' || trim('     Hello Oracle     ') || '>>>'	-- 진짜 많이 씀
  FROM dual;

-- REPLACE(), 파이썬에도 동일하게 존재
SELECT phone_number
     , replace(phone_number, '123', '786')	-- 많이 씀
  FROM EMPLOYEES;

/*
 * 슷자 함수, 집계함수와 같이 사용이 많이 됨
 * */

-- ROUND() 반올림 함수 - 파이썬 존재
-- CEIL() 올림 함수, FLOOR() 내림 함수 소수점x, TRUNC() 내림 함수 소수점o
-- MOD() 나누기 나머지 값 -- 파이썬 % 연산과 동일
-- POWER() 파이썬 math.pow(), power(), 2^10 승수계산
SELECT 786.5427 AS res1
     , round(786.5427) AS round0 -- 소수점없이
     , round(786.5427, 1) AS round1 -- 소수점1
     , round(786.5427, 2) AS round2 -- 소수점2
     , ceil(786.5427) AS ceilres
     , floor(786.5427) AS floorres
     , trunc(786.5427, 2) AS truncres
     , mod(10, 3) AS 나머지
     , power(2, 10) AS "2의 10승"
  FROM dual;

/*
 * 날짜함수, 나라마다 표현방식 다름
 * 2025-03-12 아시아 ...
 * March/12/2025 미국, 캐나다 ...
 * 12/March/2025 유럽, 인도, 베트남 ...
 * 포맷팅을 많이 함
 * */
-- 오늘 날짜
SELECT sysdate AS 오늘날짜 --GMT기준, +09필요
	-- 날짜 포맷팅 사용되는 YY, YYYY, MM, DD, DAY 년월일
	-- AM/PM, HH, HH24, MI, SS, W, Q(분기)
     , to_char(sysdate , 'yyyy-mm-dd') AS 한국식
     , to_char(sysdate , 'am hh24:mi:ss') AS 시간
     , to_char(sysdate , 'MON/DD/YYYY') AS 미국식
     , to_char(sysdate , 'DD/MM/YYYY') AS 영국식
  FROM dual;

-- ADD_MONTHS() 월 추가함수
-- MON, TUE, WED, TUR, FRI, SAT, SUN
SELECT hire_date
     , to_char(hire_date, 'yyyy-mm-dd') AS 입사일자
     , add_months(hire_date, 3) AS 정규직일자
     , next_day(hire_date, '화') AS 돌아오는요일 -- 'MON' == '월'
     , last_day('2025-02-01') AS 달마지막날
  FROM employees

-- GMT + 9
-- interval 숫자 뒤 hour, day, month, year
SELECT to_char(sysdate + INTERVAL '9' HOUR, 'yyyy-mm-dd hh24:mi:ss') AS seoul_time
  FROM dual;

/*
 * 형 변환 함수
 * */
-- TO_CHAR()
-- 숫자형을 문자형으로 변경
SELECT 12345 AS 원본
     , to_char(12345, '9999999') AS "원본+두자리빈자리"
     , to_char(12345, '0999999') AS "원본+두자리0"
     , to_char(12345, '$99999') AS "통화단위+원본"
     , to_char(12345, '99999.99') AS "소수점"
     , to_char(12345, '99,999') AS "천단위 쉼표"
  FROM dual;

-- TO_NUMBER() 문자형인 데이터를 숫자로
SELECT '5.0'
     , to_number('5.0') AS 숫자형변환
     -- to_number('hello') 숫자로 변경할 수 없는 형태
  FROM dual;

-- TO_DATE() 날짜형태를 문자형으로
SELECT '2025-03-12'
     , to_date('2025-03-12') + 10 -- 날짜형으로 바꾸면 연산가능
  FROM dual;

/* 일반 함수 */
-- NVL(컬럼|데이터, 바꿀값) 널값을 다른값으로 치환
SELECT commission_pct
     , nvl(commission_pct, 0.0) -- 꽤 쓰임
  FROM employees;

SELECT nvl(hire_date, sysdate) -- 입사일자가 비어있으면 오늘 날짜로 대체
  FROM employees
 
  
-- NVL2(컬럼|데이터, 널이 아닐 때 처리, 널일 때 처리할 부분)
SELECT commission_pct
     , salary
     , nvl2(commission_pct, salary + (salary * commission_pct), salary) AS commission_salary
  FROM employees
  
-- DECODE(a, b, '1', '2') a가 b일 경우 1, 아니면 2
-- 오라클만 있는 특징
SELECT email, phone_number, job_id
     , decode(job_id, 'IT_PROG', '개발자만세', 'ㅂㅇ') AS 캐치프레이즈
  FROM employees
-- WHERE job_id = 'IT_PROG';
  
/*
 * CASE 구문, 정말 중요
 * if, elif의 중복된 구문과 유사 - 적절하게 사용중
 * */
  
SELECT CASE job_id WHEN 'AD_PRES' THEN '사장'
				   WHEN 'AD_VP' THEN '부사장'
				   WHEN 'IT_PROG' THEN '프로그래머'
				   WHEN 'SA_MAN' THEN '영업사원'
				   ELSE '미분류'
	   END AS 직급
     , employee_id
     , job_id
  FROM employees;

/*
 * 정규식(Regular Expression) - 문자열 패턴을 가지고 동일한 패턴의 데이터를 추출하는데 사용
 * ^, $, ., *, [], [^] 패턴 인식할 때 필요한 키워드
 * */
SELECT *
  FROM employees
 WHERE phone_number LIKE '%.%.%'; -- 세자리 전화번호, 네자리 전화번호 구분 안됨
 
-- 전화번호가.로 구분되는 세자리 전화번호만 필터링
-- '[0-9]{6}-[0-9]{7}' 주민번호 정규식 패턴
SELECT *
  FROM employees
 WHERE REGEXP_LIKE(phone_number, '[0-9]{3}.[0-9]{3}.[0-9]{4}');

-- first_name이 J로 시작하고, 두번째 글자가 a나 o인 사람 출력
SELECT *
  FROM employees
 WHERE REGEXP_LIKE(first_name, '^J(a|o)');

