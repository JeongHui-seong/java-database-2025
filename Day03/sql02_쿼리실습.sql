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

-- 108P 형 변환 함수
SELECT empno, ename, to_char(hiredate,'YYYY-MM-DD') AS hiredate, to_char((sal*12)+comm, '$99,999') AS sal, to_char((((sal*12)+comm) + ((sal*12)+comm)*15/100),'$99,999') AS "15% UP"
  FROM emp
 WHERE comm IS NOT NULL;

-- 112P NVL 함수
SELECT profno, name, pay, nvl(bonus,0), (pay*12 + nvl(bonus,0)) AS total
  FROM professor
 WHERE deptno = 201;

-- 113P NVL2 함수
SELECT empno, ename, comm, nvl2(comm,'Exist','NULL') AS "NVL2"
  FROM emp
 WHERE deptno = 30;

-- 114P DECODE1
SELECT DEPTNO, NAME, DECODE(DEPTNO, '101', 'Computer Engineering', null) AS dname
  FROM PROFESSOR;

-- 115P DECODE2
SELECT deptno, name, decode(deptno, '101', 'Computer Engineering', 'ETC') AS dname
  FROM professor;

-- 116P DECODE3
SELECT deptno, name, decode(deptno, '101', 'Computer Engineering', '102', 'Multimedia Engineering', '103', 'Software Engineering', 'ETC') AS dname
  FROM professor;

-- 117P DECODE4
SELECT deptno, name, decode(deptno, '101', decode(name, 'Audie Murphy', 'BEST!', null)) AS etc
  FROM professor;

-- 118P DECODE5
SELECT deptno, name, decode(deptno, '101', decode(name, 'Audie Murphy','BEST!','GOOD!'),null)
  FROM professor;