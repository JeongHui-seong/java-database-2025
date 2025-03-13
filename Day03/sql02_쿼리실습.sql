-- 39P EX1
SELECT name || '''s ID: ' || id || ' , ' || 'WEIGHT is ' || concat(weight,'KG') AS "ID AND WEIGHT"
  FROM student;

-- 39P EX2
SELECT ENAME || '(' || job || '), ' || ENAME || '''' || JOB || '''' AS  "NAME AND JOB"
  FROM EMP
  
-- 40p EX3
SELECT ENAME || '''s sal is ' || concat('$',sal) AS "Name And Sal"
  FROM EMP
  
-- 79P SUBSTR/INSTR
SELECT name, tel, substr(tel,1,instr(tel, ')') - 1)
  FROM student
 WHERE deptno1 = 201;

-- 81P LPAD
SELECT lpad(ename,9,'12345')
  FROM emp
 WHERE deptno = 10;

-- 82P RPAD
SELECT rpad(ename, 9, '56789')
  FROM emp
 WHERE deptno = 10
 
-- 84P REPLACE1
SELECT ename, replace(ename, substr(ename,2,2), '--') AS replace
  FROM emp
 WHERE deptno = 20;

-- 84P REPLACE2
SELECT name, jumin, replace(jumin, substr(jumin,7,7), '-/-/-/-') AS replace
  FROM student
 WHERE deptno1 = 101;

-- 85P REPLACE3
SELECT name, tel, REPLACE(tel, substr(tel, instr(tel,')')+1,3),'***') AS replace
  FROM student
 WHERE deptno1 = 102;

-- 85P REPLACE4
SELECT name, tel, REPLACE(tel,substr(tel,instr(tel, '-')+1,4),'****')
  FROM student
 WHERE deptno1 = 101;

-- 105P 날짜 변환1
SELECT studno, name, to_char(birthday,'yy/mm/dd')
  FROM student
 WHERE to_char(birthday,'mm') = 01;

-- 106P 날짜 변환2
SELECT empno, ename, to_char(hiredate, 'yy/mm/dd')
  FROM emp
 WHERE to_char(hiredate,'mm') = 01
    or to_char(hiredate,'mm') = 02
    or to_char(hiredate,'mm') = 03;