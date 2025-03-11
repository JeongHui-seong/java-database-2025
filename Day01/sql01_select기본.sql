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