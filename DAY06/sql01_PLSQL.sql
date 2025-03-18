/*
 * PL/SQL
 * */

--SET SERVEROUTPUT ON; -- 콘설에서만 사용
DECLARE -- 선언부. 여기에 사용할 모든 변수를 선언
	V_EMPNO EMP.EMPNO%TYPE; -- NUMBER(4,0);를 대체해서 특정테이블의 컬럼과 같은 데이터 타입을 쓰겠다고 선언
	V_ENAME VARCHAR2(10); -- EMP.ENAME%TYPE; 와 동일
BEGIN -- PL/SQL 시작
	SELECT EMPNO, ENAME INTO V_EMPNO, V_ENAME -- 변수값을 할당
  	  FROM EMP
 	 WHERE EMPNO = :EMPNO; -- DYNAMIC 변수 원래 &EMPNO 사용
 	 -- DBEAVER 때문에 :EMPNO로 변경
		
 	-- 정상 실행 되면 
	DBMS_OUTPUT.PUT_LINE(V_EMPNO || '- 이 멤버의 이름은 ' || V_ENAME);
EXCEPTION -- 예외처리 부분
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('멤버가 없음');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('데이터가 너무 많음');
END; -- PL/SQL 끝을 지정
/

COMMIT;
