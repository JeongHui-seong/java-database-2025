/*
 * 기본 SELECT문
 * */

-- Employees 테이블에서 사원번호, 이름(이름 성 합쳐서 표시), 급여, 업무, 입사일, 상사의 사원번호로 출력하시오(107행)
SELECT * FROM EMPLOYEES e;

SELECT employee_id
     , first_name || ' ' || last_name AS full_name
     , salary, department_id
     , TO_char(hire_date, 'yyyy-mm-dd') AS hire_date
     , manager_id
  FROM employees e;

-- Employees 테이블에서 모든 사원의 이름(last_name)과 연봉을 '이름: 1 year salary = $연봉' 형식으로
-- 출력하고, 컬럼명을 1 year salary로 변경하시오 (107행)
SELECT last_name || ': 1 year salary =' || to_char(salary * 12, '$999,999.99') AS "1 year salary"
  FROM employees;

-- 부서별로 담당하는 업무를 한 번씩만 출력하시오. (20행)
SELECT DISTINCT department_id, job_id
  FROM employees;

/*
 * WHERE절, ORDER BY절 
 */
-- EMPLOYEES에서 급여가 7000~10000달러 범위이외 사람의 이름과 성을 FULL_NAME, 급여를 오름차순으로 출력하시오(75행)
SELECT FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME
     , SALARY
  FROM EMPLOYEES
 WHERE SALARY NOT BETWEEN 7000 AND 10000
 ORDER BY SALARY ASC;

-- 현재 날짜타입을 날짜 함수를 통해서 확인하고,
-- 입사일자가 2003년 5월 20일부터 2004년 5월 20일 사이에 입사한 사원의 이름(FULL_NAME), 사원번호, 고용일자를 출력하시오
-- 단, 입사일을 빠른순으로 정렬하시오(10행)
SELECT FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME, EMPLOYEE_ID, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS HIRE_DATE
  FROM EMPLOYEES
 WHERE HIRE_DATE BETWEEN '2003-05-20' AND '2004-05-20'
 ORDER BY HIRE_DATE;

/*
 * 단일행 함수와 변환 함수
 * */
-- 이번 분기, 60번 IT부서가 지대한 공헌을 했음
-- IT부서 사원 급여를 15.3% 인상하기로 했다. 정수만 반올림
-- 출력형식은 사번, 이름과 성(FULL_NAME), 급여, 인상된 급여(컬럼명 INCREASED SALARY) 출력 (5행)
SELECT EMPLOYEE_ID
     , FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME
     , SALARY
     , ROUND(SALARY + (SALARY * 0.153)) AS "INCREASED SALARY"
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG';

-- 모든 사원의 연봉을 표시하는 보고서 작성
-- 사원 FULL_NAME, 급여, 수당여부에 따라 연봉을 표시하시오
-- 수당이 있으면 SALARY + COMMISSION, 없으면 SALARY ONLY라고 표시. 연봉이 높은 순으로 정렬(107행)
SELECT FIRST_NAME || ' ' || 'LAST_NAME' AS FULL_NAME
     , SALARY
     , SALARY * 12 + (SALARY * NVL(EMPLOYEES.COMMISSION_PCT,0)) AS "ANNUAL SALARY"
     , DECODE(COMMISSION_PCT, NULL, 'SALARY ONLY', 'SALARY + COMMISSION_PCT') AS COMMISSION
  FROM EMPLOYEES
 ORDER BY 3 DESC; -- "ANNUAL SALARY"보다 컬럼순서인 3을 적는게 훨씬 효율적

SELECT CASE WHEN COMMISSION_PCT IS NULL THEN 'SALARY ONLY'
			WHEN COMMISSION_PCT IS NOT NULL THEN 'SALARY + COMMISSION'
			END AS "COMMISSION ?"
  FROM EMPLOYEES
 ORDER BY SALARY;

/*
 * 집계함수, MIN, MAX, SUM, AVG, COUNT...
 * */
-- EMPLOYEES에서 각 사원이 소속된 부서별 급여합계, 급여평균, 급여최대값, 급여최소값 집계
-- 출력형식은 여섯자리와 세자리 구분기호, $를 앞에 표시. 부서 번호의 오름차순으로 정렬
-- 단 부서에 소속되지 않은 사원은 제외(11행)
SELECT DEPARTMENT_ID, TO_CHAR(SUM(SALARY),'$999,999') AS SUM_SALARY
     , TO_CHAR(AVG(SALARY),'$999,999.9') AS AVG_SALARY
     , TO_CHAR(MAX(SALARY),'$999,999') AS MAX_SALARY
     , TO_CHAR(MIN(SALARY),'$999,999') AS MIN_SALARY
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IS NOT NULL
 GROUP BY DEPARTMENT_ID
 ORDER BY DEPARTMENT_ID;

/*
 * JOIN
 * */
-- EMPLOYEES, DEPARTMENT, LOCATIONS 테이블 구조 파악
-- OXFORD에 근무하는 사원 FULL_NAME, 업무, 부서명, 도시명을 출력 (34행)
SELECT e.first_name || ' ' || e.LAST_name AS full_name
     , e.JOB_ID
     , d.DEPARTMENT_name
     , l.city
  FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
   AND D.LOCATION_ID = L.LOCATION_ID
   AND L.CITY = 'Oxford';

-- 부서가 없는 직원까지 모두 부서명을 출력
select e.first_name || ' ' || e.LAST_name AS full_name
     , e.JOB_ID 
     , d.DEPARTMENT_NAME
  FROM EMPLOYEES E, DEPARTMENTS D
  WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

/*
 * 서브쿼리
 * */
-- Tucker 사원보다 급여를 많이 받는 사원의 full_name, 업무, 급여를 출력
SELECT FIRST_NAME || ' ' || 'LAST_NAME' AS FULL_NAME7
     , job_id
     , salary
  FROM employees
 WHERE salary > (SELECT salary
  				   FROM employees
 				  WHERE last_name = 'Tucker');


-- 부서와 업무별 급여합계를 구하여 급여수준 레벨을 지정하고자 함
-- 부서별, 업무별 급여합계 및 각 부서별 총합, 각 부서별, 업무별 직원수를 출력

SELECT department_id, job_id
     , to_char(sum(salary), '$999,999') AS "Sum Salary"
     , count(*) AS "Employees Count"
  FROM employees
 GROUP BY ROLLUP(department_id, job_id);

COMMIT;