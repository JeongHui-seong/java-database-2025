/*
 * 복수행, GROUP BY와 가장 많이 사용
 * COUNT(),SUM(), AVG(), MIN/MAX(), STDDEV(), ...
 * ROLLUP, CUBE, RANK, DENSE_RANK ...
 * */
-- COUNT() -- 많이 씀
SELECT COUNT(*) --scalar value
  FROM EMPLOYEES;

SELECT COUNT(employee_id) --scalar value
  FROM EMPLOYEES;

-- SUM(숫자형 컬럼) 합계
-- employees 206 salary 8300 삭제
SELECT sum(salary)
  FROM employees;

-- AVG(숫자형 컬럼)
-- 컬럼에 NULL값이 있으면 제외하고 계산하기 때문에 잘못된 값 반환
-- 금액이나 수량을 계산하는 컬럼의 NULL값은 전처리 필수
SELECT avg(salary)
  FROM employees;

SELECT count(salary)
  FROM employees;

-- MIN(숫자|문자형 컬럼), MAX()
SELECT max(first_name), min(salary)
  FROM employees;

/*
 * GROUP BY 연계, 그룹화
 * GROUP BY를 사용하면 select절에는 group by 사용한 컬럼과 집계함수 및 일반함수만 사용 가능
 * */
-- 아래의 경우 department_id 이외의 컬럼은 사용불가
SELECT department_id
     , avg(salary) AS 부서별평균급여
     , to_char(round(avg(salary), 1), '99,999.9')
     , sum(salary) AS 부서별급여총액
  FROM employees
 GROUP BY department_id
 ORDER BY avg(salary) deSC;

-- employees에서 부서와 직군별 급여총액과 직원수를 출력
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
     , count(*)
  FROM employees
 GROUP BY department_id, job_id
 ORDER BY department_id;

-- employees에서 부서와 직군별 급여총액과 직원수를 출력하는데
-- department_id가 30~90, 부서직군별급여총액이 20000이상인 데이터만 출력
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
     , count(*)
  FROM employees
 WHERE department_id BETWEEN 30 AND 90
-- AND sum(salary) >= 20000 집계함수는 where에 사용불가
 GROUP BY department_id, job_id
HAVING sum(salary) >= 20000
 ORDER BY department_id;

-- ORDER BY에는 컬럼의 순번(1부터 시작)으로 컬럼명을 대체가능
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
     , count(*)
  FROM employees
 WHERE department_id BETWEEN 30 AND 90
 GROUP BY department_id, job_id
HAVING sum(salary) >= 20000
 ORDER BY 3 DESC;

-- ROLLUP 그룹별 소계와 총계를 표시해주는 기능, ORDER BY절 안씀
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
     , count(*)
  FROM employees
 WHERE department_id BETWEEN 30 AND 90
 GROUP BY ROLLUP (department_id, job_id);

-- PIVOT() 엑셀에 동일한 기능
-- PIVOT 안쓰고 각 달별로 입사한 사원의 수 표시 12행
-- 각 입사일자에서 달만 추출
SELECT to_char(hire_date, 'mm')
  FROM employees;

-- 입사 달별로 그루핑
SELECT to_char(hire_date, 'mm')
  FROM employees
  GROUP BY to_char(hire_date, 'mm');

-- 1월달에 입사한 사람 카운팅 
SELECT CASE to_char(hire_date, 'mm') WHEN '01' THEN count(*) ELSE 0 END AS "1월"
  FROM employees
 GROUP BY to_char(hire_date, 'mm');

-- 옆으로 각달별로 스프레드
SELECT CASE to_char(hire_date, 'mm') WHEN '01' THEN count(*) ELSE 0 END AS "1월"
     , CASE to_char(hire_date, 'mm') WHEN '02' THEN count(*) ELSE 0 END AS "2월"
     , CASE to_char(hire_date, 'mm') WHEN '03' THEN count(*) ELSE 0 END AS "3월"
     , CASE to_char(hire_date, 'mm') WHEN '04' THEN count(*) ELSE 0 END AS "4월"
     , CASE to_char(hire_date, 'mm') WHEN '05' THEN count(*) ELSE 0 END AS "5월"
     , CASE to_char(hire_date, 'mm') WHEN '06' THEN count(*) ELSE 0 END AS "6월"
     , CASE to_char(hire_date, 'mm') WHEN '07' THEN count(*) ELSE 0 END AS "7월"
     , CASE to_char(hire_date, 'mm') WHEN '08' THEN count(*) ELSE 0 END AS "8월"
     , CASE to_char(hire_date, 'mm') WHEN '09' THEN count(*) ELSE 0 END AS "9월"
     , CASE to_char(hire_date, 'mm') WHEN '10' THEN count(*) ELSE 0 END AS "10월"
     , CASE to_char(hire_date, 'mm') WHEN '11' THEN count(*) ELSE 0 END AS "11월"
     , CASE to_char(hire_date, 'mm') WHEN '12' THEN count(*) ELSE 0 END AS "12월"
  FROM employees
 GROUP BY to_char(hire_date, 'mm')
 ORDER BY to_char(hire_date, 'mm');

-- DECODE
SELECT decode(to_char(hire_date, 'mm'), '01', count(*), 0) AS "1월"
     , decode(to_char(hire_date, 'mm'), '02', count(*), 0) AS "2월"
     , decode(to_char(hire_date, 'mm'), '03', count(*), 0) AS "3월"
     , decode(to_char(hire_date, 'mm'), '04', count(*), 0) AS "4월"
     , decode(to_char(hire_date, 'mm'), '05', count(*), 0) AS "5월"
     , decode(to_char(hire_date, 'mm'), '06', count(*), 0) AS "6월"
     , decode(to_char(hire_date, 'mm'), '07', count(*), 0) AS "7월"
     , decode(to_char(hire_date, 'mm'), '08', count(*), 0) AS "8월"
     , decode(to_char(hire_date, 'mm'), '09', count(*), 0) AS "9월"
     , decode(to_char(hire_date, 'mm'), '10', count(*), 0) AS "10월"
     , decode(to_char(hire_date, 'mm'), '11', count(*), 0) AS "11월"
     , decode(to_char(hire_date, 'mm'), '12', count(*), 0) AS "12월"
  FROM employees
 GROUP BY to_char(hire_date, 'mm')
 ORDER BY to_char(hire_date, 'mm');

-- RANK() 등수 공동 등수 번호가 띄어넘어감, DENSE_RANK() 등수번호가 순차적으로 올라감
-- ROW_NUMBER() 현재 데이터 행 번호 출력
SELECT employee_id, LAST_name, salary
	 , rank() OVER (ORDER BY salary DESC) AS 랭크 -- 잘안씀
	 , dense_rank() OVER (ORDER BY salary DESC) AS 랭크 -- 일반적으로 많이 사용
	 , row_number() OVER (ORDER BY salary DESC) AS 행번호
  FROM employees;
  
COMMIT;