/*
 * SQL - DML - SELECT 학습
 */

-- 01. HR.employees 테이블의 모든 데이터 조회(107건)
SELECT * -- astrick -> all로 발음, 모든 컬럼을 다 보여라
  FROM employees;

-- 02. HR.employees중 employee_id, first_name, last_name, email, hire_date를 출력하라(107행)
SELECT employee_id, first_name, last_name, email, hire_date
  FROM employees;

-- 03. 02번의 쿼리를 컬럼명을 변경해서 출력, '직원번호', '이름', '성', '이메일', '입사일자'로 변경 (107행)
-- alias 별명
SELECT employee_id AS "직원번호"
     , first_name AS "이름"
     , last_name AS "성"
     , email AS "이메일"
     , hire_date AS "입사일자"
  FROM employees;

-- 04. employees에서 job_id가 중복되지 않게 출력
-- distinct - 중복제거, all - 전부 다
SELECT DISTINCT job_id
  FROM employees;

-- 05. employees 테이블의 이름과 성을 붙여서 full_name으로, phone_number를 출력하시오(107행)
SELECT first_name || ' ' || last_name AS "full_name"
      ,phone_number
  FROM employees;

-- 06. employees 테이블의 직원들 정보를 아래와 같이 나오도록 출력하시오 (107행)
/*
 * total info 라는 컬럼으로 이름 변경
 * full_name(employee_id) - job_id[hire_date] / phone_number 하나의 컬럼에
 * Steven King(100) - AD_PRES[2003-06-17 00:00:00] / 515.123.4567
 */
SELECT first_name || ' ' || last_name || '(' || employee_id || ') - ' || job_id || '[' || hire_date || '] / ' || phone_number AS "total info"
  FROM employees;

/*
 * 조건절 - WHERE
 * */
-- 연습. employees 테이블에서 employee_id가 110인 직원 출력 (1행)
SELECT *
  FROM employees
 WHERE employee_id = 110;

-- first_name이 John인 직원 출력
SELECT *
  FROM employees
 WHERE first_name = 'John';

-- hire_date가 2006-02-12인 직원 출력
SELECT *
  FROM employees
 WHERE hire_date = '2006-02-12'; --날짜타입은 문자열처럼 비교
 
-- 데이터 타입 숫자형, 문자형, 날짜형 등

/*
 * WHERE절에 사용하는 연산자
 * ● = : equal 타 프로그래밍 언어와 달리 = 하나만 사용
 * ● !=, <> : not equal 같지 않다
 * ● >, >=, <, <= : 크다, 크거나 같다, 작다, 작거나 같다
 * ● BETWEEN A AND B : 특정 값이 A이상 B이하에 포함되어있다
 * ● IN(A, B, C) : 특정 값이 A이거나 B이거나 C중 하나
 * ● LIKE : SQL에서 문자열 비교시 특화된 연산자
 * ● NULL비교,  IS NULL, IS NOT NULL : NULL값을 검색할 때, NULL값이 아닌 걸 검색할 때
 * ● A AND B : A와 B 조건을 모두 만족해야 True
 * ● A OR B : A와 B 둘 중 하나라도 조건을 만족하면 True
 * ● NOT A : A가 아닌 조건, 반대조건
 */
 
 SELECT *
  FROM employees
 WHERE hire_date != '2006-02-12';

-- between은 초과, 미만이 아닌 이상, 이하임
 SELECT *
  FROM employees
 WHERE salary BETWEEN 9000 AND 15000;
 
-- and 와 >=, <=로 똑같이 구현 가능
 SELECT *
   FROM EMPLOYEes
  WHERE salary >= 9000 AND salary <= 15000;

SELECT *
  FROM EMPLOYEES
 WHERE first_name IN ('John', 'Steven', 'Neena');
 
SELECT *
  FROM EMPLOYEES
 WHERE first_name = 'John'
    OR first_name =  'Steven'
    OR first_name =  'Neena';
    
-- NULL비교
SELECT *
  FROM EMPLOYEES
 WHERE commission_pct IS NULL;

SELECT *
  FROM EMPLOYEES
 WHERE commission_pct IS NOT NULL;
 
-- LIKE 문자열 패턴으로 검색
-- % 앞에 무슨 글자들이 있던 상관없이
SELECT *
  FROM employees
 WHERE job_id LIKE '%MAN'; -- 앞쪽 문자열은 뭐든지 상관 없고 MAN으로 끝나는 패턴을 찾음
 
 SELECT *
  FROM employees
 WHERE last_name LIKE 'Ra%'; -- 뒤쪽 문자열은 상관없고 Ra로 시작하는 패턴을 가진 문자 찾음
 
 SELECT *
  FROM employees
 WHERE job_id LIKE '%MAN%'; -- 문자열 내 어디든지 MAN이 들어가는 문자열은 다 찾아라
 
 SELECT *
  FROM employees
 WHERE last_name LIKE 'Ra__'; -- 총 네글자 중 Ra로 시작하는 패턴 찾아라

-- 07. employee에서 hire_date가 2005-01-01 이후에 입사했고, salary가 10000 이상인 직원 출력 (9행)
--     이름, 이메일, 전화번호, 입사일, 급여 표시
 SELECT first_name || ' ' || last_name AS "이름"
      , email AS "이메일"
      , phone_number AS "전화번호"
      , hire_date AS "입사일"
      , salary AS "급여"
  FROM employees
 WHERE hire_date > '2005-01-01'
   AND salary >= 10000
   
/*
 * 정렬 - ORDER BY
 * ASC - 오름차순, 생략가능
 * DESC - 내림차순
 * */
SELECT *
  FROM employees
 ORDER BY salary asc;

SELECT *
  FROM employees
 ORDER BY commission_pct desc;

SELECT *
  FROM employees
 ORDER BY job_id ASC, salary desc;

/*
 * 집합, UNION, UNION ALL, INTERSECT, MINUS
 */
-- SELECT * FROM DEPARTMENTS d
-- departments에서 department_id가 50이하인 부서아이디와 부서명 데이터
-- employees에서 employee_id가 110에서 150 사이인 직원 아이디와 직원명(first_name || last_name)를 합쳐서 출력
SELECT department_id, department_name
  FROM departments
 WHERE department_id <= 50
UNION
SELECT employee_id, first_name || ' ' || last_name AS "full_name"
  FROM employees
 WHERE employee_id BETWEEN 110 AND 150
 

