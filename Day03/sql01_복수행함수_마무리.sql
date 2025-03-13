/*
 * 복수행 함수 마무리
 * */
-- GROUP BY, HAVING
-- 그룹핑시 GROUP BY에 들어가는 컬럼만 select절에 사용 가능
-- WHERE 절은 일반적 조건만 비교, HAVING은 집계함수를 조건에 사용할 때
SELECT department_id
     , sum(salary)
  FROM employees
 WHERE department_id <= 70
 GROUP BY department_id
HAVING sum(salary) <= 20000
 ORDER BY 2; -- sum(salary)와 동일. SELECT절 순서에 따라서
 
-- RANK() - 1, 2, 2, 4
-- DENSE_RANK() - 1, 2, 2, 3
-- ROW_NUMBER() - 행번호
-- 전체 employees에서 급여가 높은 사람부터 순위매김 
SELECT first_name || ' ' || last_name AS full_name
	 , salary
	 , department_id
	 , rank() OVER (ORDER BY salary desc) AS "RANK"
	 , DENSE_RANK() OVER (order BY salary desc) AS "DENSERANK"-- 일상에서 더 많이 사용
	 , row_number() OVER (ORDER BY salary desc) AS "ROWNUM"
  FROM employees
 WHERE salary IS NOT NULL;

-- 부서별(department_id) 급여 높은 사람부터 순위매김
SELECT first_name || ' ' || last_name AS full_name
	 , salary
	 , department_id
	 , rank() OVER (PARTITION BY department_id ORDER BY salary desc) AS "RANK"
	 , DENSE_RANK() OVER (PARTITION BY department_id order BY salary desc) AS "DENSERANK"-- 일상에서 더 많이 사용
	 , row_number() OVER (PARTITION BY department_id ORDER BY salary desc) AS "ROWNUM" -- PARTITION BY 잘 사용 안함
  FROM employees
 WHERE salary IS NOT NULL
 ORDER BY DEPARTMENT_ID;