# java-database-2025
Java개발자 과장 Database 리포지토리 (Oracle)

## 1일차
- Github Desktop 설치
    - https://desktop.github.com/download/ 다운로드
    - 기존 Github 계정으로 로그인
    - Git 명령어 없이 사용 가능
- Database(DB) 개요
    - 데이터를 저장하는 장소, 서비스를 하는 서버
    - 데이터베이스를 관리하는 프로그램 DBMS
    - 가장 유명한 것이 Oracle
    - 사용자는 SQL로 요청, DB서버는 처리결과를 테이블로 리턴
    - SQL을 배우는 것이 목적
- Oracle 설치(Docker)
    1. Powershell 오픈
    2. Docker search로 다운로드하고 싶은 이미지 검색
    3. Docker pull 내려받기
        ```shell
        > docker pull oracleinanutshell/oracle-xe-11g
        ```
    4. 다운로드 이미지 확인
        ```shell
        PS C:\Users\Admin> docker image ls
        REPOSITORY              TAG       IMAGE ID       CREATED        SIZE
        
        oracleinanutshell/oracle-xe-11g   latest    8b740e77d4b9   6 years ago    2.79GB
        ```
    5. 도커 컨테이너 실행
        ```shell
        > docker run --name oracle11g -d -p 1521:1521 --restart=always oracleinanutshell/oracle-xe-11g
        ```
        - 1521 - 오라클 기본 포트
        - 아이디 system / oracle
    6. 도커 실행확인
        - Docker Desktop > Containers 확인
    7. Powershell 오픈
        ```shell
        > docker exec -it oracle11g bash
        [oracle@... ~]$ sqlplus / as sysdba
        SQL >
        ```
    8. DBeaver 접속
        - Connection > Select your DB > Oracle 선택
        <img src = "C:\Source\java-database-2025\image\db001.png" width = "650">
- DBeaver Community 툴 설치C:\Source\java-database-2025\image\db001.png
    - https://dbeaver.io/download/
- DML, DDL, DCL
    - 언어의 특징을 가지고 있음
        - 프로그래밍 언어 - 어떻게(How)
        - SQL - 무엇(What)
    - SQL의 구성요소 3가지
        - DDL(Data Definition Lang) - 데이터베이스 생성, 테이블 생성, 객체 생성, 수정, 삭제
            - CREATE, ALTER, DROP ...
        - DCL(Data Control Lang) - 사용자 권한 부여, 해제, 트랜잭션 시작, 종료
            - GRANT, REVOKE, BEGIN TRANS, COMMIT, ROLLBACK
        - **DML**(Data Manupulation Lang) - 데이터 조작언어(핵심), 데이터 삽입, 조회, 수정, 삭제
            - `INSERT`, `SELECT`, `UPDATE`, `DELETE`
- SELECT 기본
    - 데이터 조회 시 사용하는 기본명령어
        ```sql
        -- 기본 주석(한줄)
        /* 여러줄
        주석 */
         SELECT [ALL|DISTINCT] [*|컬럼명(들)]
           FROM 테이블명(들)
         [WHERE 검색조건(들)]
         [GROUP BY 속성명(들)]
        [HAVING 집계함수조건(들)]
         [ORDER BY 정렬속성(들) ASC|DESC]
          [WITH ROLLUP]
        ```
    - 기본 쿼리 학습 : [SQL](./Day01/sql01_select기본.sql)
        1. 기본 SELECT
        2. WHERE 조건절
        3. NULL(!)
        4. ORDER BY 정렬
        5. 집합

- 함수(내장함수)
    - 문자함수 : [SQL](./Day01/sql02_함수.sql)
    - 숫자함수
## 2일차
- 함수(계속)
    - 문자함수부터 : [SQL](./Day02/sql01_함수계속.sql)
    - 숫자함수
    - 날짜함수
    - 형변환함수
- 복수행함수 : [SQL](./Day02/sql02-복수행함수.sql)
    - 집계함수
    - GROUP BY
    - HAVING
    - ROLLUP
    - RANK, DENSE_RANK, ROW_NUMBER

- 데이터베이스 타입형
    - **CHAT(n)** - 고정형 문자열, 최대 2000바이트
        - CHAR(20)으로 'Hello World'를 저장하면, 'Hello World        '로 저장 (공백포함됨)
        - 기준코드나 반드시 자리수를 지켜야하는 데이터 필요, 주민번호 등
    - **VARCHAR2(n)** - 가변형 문자열, 최대 4000바이트
        - VARCHAR2(20)로 'Hello World', 'Hello World'로 저장
    - **NUMBER(p, s)** - 숫자값, p 전체자리수, s 소수점길이, 최대 22byte
    - INTERGER - 모든 데이터의 기준. 4byte, 정수를 담는 데이터형
    - FLOAT(p) - 실수형 타입, 최대 22byte 
    - **DATE** - 날짜타입
    - **LONG(n)** - 가변길이 문자열, 최대 2Gbyte
    - LONG RAW(n) - 원시이진 데이터, 최대 2Gbyte
    - CLOB - 대용량 텍스트 데이터타입, 최대 4Gbyte
    - BLOB - 대용량 바이너리 데이터타입, 최대 4Gbyte
    - BFILE - 외부 파일 에 저장된 데이터, 최대 4Gbyte

## 3일차
- 쿼리 실습 : [SQL](./Day03/sql02_쿼리실습.sql)
- JOIN : [SQL](./Day03/sql03_조인기본.sql)
    - ERD (Entity Relationship Diagram) - 개체 관계 다이어그램
        - PK(Primary Key) - 기본키. 중복이 안되고 빠진 데이터가 하나도 없다. UNIQUE, NOT NULL
        - FK(Foreign Key) - 외래키. 다른 엔티티(테이블)의 PK, 두 엔티티의 관계를 연결해주는 값
        - Relationship - 부모 엔티티와 자식 엔티티간의 연관 관계, 부모1:자식N을 가질 수 있음
    - 카티션곱
        - 두 개 이상의 테이블의 조건과 관계없이 연결할 수 있는 경우의 수를 모두 만든 데이터
        - 조인 이전에 데이터 확인 - 실무에서 카티션곱으로 데이터를 사용할 일이 절대 없음
    - 내부조인
        - 다중 테이블에서 보통 PK와 FK간의 일치하는 데이터를 한꺼번에 출력하기 위한 방법
        - 관계형 데이터베이스에서 필수로 사용해야 함
        - INNER JOIN 또는 오라클 간결 문법으로 사용
    - 외부조인
        - PK와 FK간 일치하지 않는 데이터도 출력하고자 할 때 사용하는 방법
        - LEFT OUTER JOIN, RIGHT OUTER JOIN 또는 오라클 간결 문법 사용
- DDL : [SQL](./Day03/sql04_DDL.sql)
    - CREATE - TABLE, VIEW, PROCEDURE, FUNCTION, 개체를 생성하는 키워드
    ```sql
    CREATE TABLE 테이블명 (
        첫번째_컬럼 타입형 제약조건,
        두번째_컬럼 타입형 제약조건,
        ...
        마지막_컬럼 타입형 제약조건
        [기본키, 외래키 등의 옵션...]
    );
    ```
    - ALTER - 개체 중 테이블에서 수정이 필요할 때 사용하는 키워드
        ```sql
        ALTER TABLE 테이블명 ADD (컬럼명 타입형 제약조건);
        ALTER TABLE 테이블명 MODIFY (컬럼명 타입형 제약조건);
        ```
    - DROP - 개체 삭제 시 사용하는 키워드
        ```sql
        DROP TABLE 테이블명 purge; --purge는 휴지통
        ```
    - TRUNCATE - 테이블 완전 초기화 키워드
        ```sql
        TRUNCATE TABLE 테이블명;
        ```

## 4일차
- VS Code DB플러그인
    - 확장 > Database 검색 > Database Client(Weijan Chen) > 확장 중 Database 선택
    <img src = "./image/db002.png" width = 700>
- DML [INSERT 쿼리](./Day04/sql01_INSERT.sql) [UPDATE,DELETE 쿼리](./Day04/sql02_UPDATE_DELETE.sql)
    - INSERT - 테이블에 새로운 데이터를 삽입하는 명령
        - 한 건씩 삽입
        ```sql
        INSERT INTO 테이블명 [(컬럼리스트)]
        VALUES (값리스트);
        ```
        - 여러건 한꺼번에 삽입
        ```sql
        INSERT ALL
                INTO 테이블명 VALUES (값리스트)
                INTO 테이블명 VALUES (값리스트)
                ...
        SELECT * FROM DUAL;
        ```
    - UPDATE - 데이터 변경 WHERE 조건을 없이 실행하면 테이블 모든 데이터가 수정(주의요망)
        ```sql
        UPDATE 테이블명 SET
            컬럼명 = 변경할값,
            [컬럼명 = 변경할값,] -- 반복
        [WHERE 조건]
        ```
    - DELETE - 데이터 삭제 WHERE 조건 없이 실행하면 테이블의 모든 데이터가 삭제됨(주의요망)
        ```sql
        DELETE FROM 테이블명
        [WHERE 조건];
        ```
- 트랜잭션 [트랜잭션](./Day04/sql03_transaction.sql)
    - 논리적인 처리단위
    - 은행에서 돈을 찾을 때 아주 많은 테이블 접근해서 일처리
        - 적어도 7,8개 이상의 테이블에 접근해서 조회하고 업데이트 수행
        - 제대로 일이 처리안되면 다시 원상복구
        - DB 설정에 AUTO COMMIT 해제 권장
        - ROLLBACK 트랜잭션 종료가 아님 COMMIT만 종료
        ```sql
        SET TRANSACTION READ WRITE; -- 트랜잭션 시작(옵션)
        COMMIT; -- 트랜잭션 확정
        ROLLBACK; -- 원상복구
        ```
- 제약조건(Constraint) [제약조건](./Day04/sql04_constraint.sql)
    - 잘못된 데이터가 들어가지 않도록 막는 기법
        - PRIMARY KEY - 기본키, UNIQUE NOT NULL, 중복되지 않고 없어도 안됨
        - FOREIGH KEY - 외래키, 다른 테이블의 PK에 없는 값을 가져다 쓸 수 없음
        - NOT NULL - 값이 빠지면 안됨
        - UNIQUE - 들어간 데이터가 중복되면 안됨
        - CHECK - 기준에 부합하지 않는 데이터는 입력되면 안됨
        - DEFAULT - NULL 입력시 기본값이 입력되도록 하는 제약조건
        ```sql
        CREATE TABLE 테이블명 (
            컬럼 생성시 제약조건 추가
        );

        ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건;
        ```
- INDEX [인덱스](./Day04/sql05_index.sql), [인덱스용테이블생성](./ref/bulk_data_insert.sql)
    - 책의 찾아보기와 동일한 기능
    - 검색을 매우 빨리 할 수 있도록 해줌
    - B(alanced) Tree를 사용해서 검색횟수를 log(n)건로 줄임
    - 인덱스 종류
        - 클러스터드(Clustered) 인덱스 (테이블 당 1개)
            - PK에 자동으로 생성되는 인덱스 (빠름)
            - PK가 없으면 처음으로 설정되는 UNIQUE 제약조건의 컬럼에 생성
        - 보조(Non-clustered) 인덱스 (여러개)
            - 사용자가 추가하는 인덱스
            - 클러스터드 인덱스보다 조금 느림
    - 유의점
        - PK에 자동 인덱스 후 컬럼에 UNIQUE를 걸어도 인덱스가 생성안됨. 수동으로 생성 필요
        - WHERE절에서 검색하는 컬럼은 인덱스를 걸어주는 것이 성능향상에 도움
        - 인덱스는 한 테이블당 4개이상 걸면 성능 저하
        - NULL값, 중복값이 많은 컬럼에 인덱스는 성능 저하
        - INSERT, UPDATE, DELETE가 많이 방생하는 테이블에 인덱스를 걸면 성능 저하

    ```sql
    CREATE INDEX 인덱스명 ON 테이블명(인덱스를 걸 컬럼명);
    ```
## 5일차
- VIEW [뷰](./DAY05/sql01_VIEW.sql)
    - 기존 테이블에서 권한별로 보일 수 있는 컬럼을 지정해서 만드는 개체 (보안목적)
    - 기존 테이블 중 개인정보나 중요한 부분이 있으면 제외하고 보일 수 있음
    - 뷰라도 INSERT, UPDATE, DELETE 가능. 단일 뷰에서만
        ```sql
        CREATE VIEW 뷰명
        AS
            SELECT 쿼리;
        [WITH READ ONLY]
        ```
    - 복합뷰는 두 개 이상의 테이블을 조인해서 만든 뷰. DML기능 불가

- 서브쿼리 [서브쿼리](./DAY05/sql02_SUBQUERY.sql)
    - 메인쿼리를 도와주는 하위쿼리 뜻함 소괄호() 내에 포함됨
    - 단일행 서브쿼리, 다중행 서브쿼리마다 사용법 다름
    - SELECT절(스칼라) 서브쿼리, FROM절 서브쿼리, WHERE절 서브쿼리
    - 서브쿼리는 JOIN으로 거의 다 변경 가능 (안되는 경우도 있음)

- 시퀀스 [시퀀스](./DAY05/sql03_SEQUENCE.sql)
    - 번호로 지정된 PK값을 자동으로 삽입할 수 있도록 도와주는 기능
    - 없어도 기능에는 차이가 없지만 효율을 위해서 사용
    - ORACLE만 존재
    ```sql
    CREATE SEQUENCE 시퀀스명
    INCREMENT BY 1 -- 증가값
    START WITH 1 -- 초기 시작값
    [MAXVALUE 99999] -- 최대 증가값
    [CYCLE] -- 최대 증가값에 도달하면 다시 처음으로 돌아갈 것인지
    [CACHE] -- 번호 증가 캐시(대용량 삽입시만 관계)

    시퀀스명.NEXTVAL
    시퀀스명.CURRVAL
    ```

- 실습 [실습](./DAY05/sql04_실습.sql)

- 사용자 계정 권한 [쿼리](./DAY05/sql05_사용자계정관리.sql)
    - 사용자 생성 후 권한(롤)을 부여해야 스키마를 사용가능

        ```SQL
        -- 권한 부여
        GRANT 권한|롤 TO 사용자 [WITH ADMIN OPTION];
        -- 권한 해제
        REVOKE 권한|롤 FROM 사용자;
        ```

## 6일차
- PL/SQL - ORACLE에서 파이썬처럼 코딩 [PL/SQL](./DAY06/sql01_PLSQL.sql)
    - 오라클에서 프로그래밍을 하기 위한 언어
    - 기본 구조
        - 선언부(DECLARE), 실행부(BEGIN-END), 예외처리부(EXCEPTION) 구성
     - Oracle 스키마 중 Packages, Procedures, Functions이 PL/SQL로 작업하는 영역
        - 저장된(Stored) PL/SQL
    - 결과 화면에 출력하려면 명령어를 실행하고 PL/SQL을 수행해야함
    ```sql
    SET SERVEROUTPUT ON; -- 화면 출력기능 활성화
    SHOW ERRORS; -- 오류 상세내용 보기
    ```
- Stored Procedure와 Function을 만들기 위해서 사용
    - 저장 프로시져 [PROCEDURE1](./DAY06/sql02_PROCEDURE.sql) [PROCEDURE2](./DAY06/sql03_PROCEDURE.sql) [PROCEDURE3](./DAY06/sql04_PROCEDURE.sql) [PROCEDURE4](./DAY06/sql04_PROCEDURE.sql)
        - 한꺼번에 많은 일을 수행해야할 때(Transaction당 수행되는 로직들 묶어서)
        - 예: 한번에 5개의 테이블에서 조회와 DML을 처리해야한다
            - 쿼리를 최소 10개를 수행해야 함
            - 프로시저 한 번만 수행해서 해결 가능
        - 중대형 IT솔루션에서는 프로시저가 거의 필수

    ```sql
    CREATE OR REPLACE PROCEDURE 프로시져명
    (
        PARAM1 DATATYPE,
        PARAM2 DATATYPE,
        ...
    )
    IS|AS
    PL/SQL BLOCK;
    /
    ```

    - 실행시 CALL|EXEC 사용 [PROCEDURE 실행](./DAY06/sql06_PROCEDURE_실행.sql)
    ```sql
    CALL 프로시저명(파라미터);
    EXEC 프로시저명(파라미터); -- DBEAVER에서 사용 불가
    ```

    - 함수 [FUNCTION1](./DAY06/sql07_FUNCTION.sql) [FUNCTION2](./DAY06/sql08_FUNCTION.sql)
        - 스칼라값을 리턴할 때 - Select절 서브쿼리와 기능이 동일
        - 개발자에게 편의성을 제공하기 위해서 만듬
    
    ```sql
    CREATE OR REPLACE FUNCTION 함수명
    (
        PARAM1 DATATYPE,
        ...
    )
    RETURN DATATYPE
    IS|AS
    PL/SQL BLOCK;
    /
    ```

    - 실행시 SELECT문등 DML문과 같이 사용
    ```sql
    SELECT *, 함수명(파라미터)
      FROM 컬럼명;
    ```
    [PROCEDURE연습1](./DAY06/sql10_PROCEDURE연습.sql) [PROCEDURE연습2](./DAY06/sql11_PROCEDURE연습.sql)
- 커서 [CURSOR](./DAY06/sql12_CURSOR.sql)
    - DB에서 테이블에 들어있는 데이터를 한 줄씩 읽기 위해서 필요

    ```sql
    CURSOR 커서명 IS
        SELECT쿼리;
    ```
    [PROCEDURE실행](./DAY06/sql13_PROSEDURE_실행.sql)

- 트리거 [TRIGGER](./DAY06/sql14_TRIGGER.sql)
    - 특정 동작으로 다른 테이블에 자동으로 데이터가 변경되는 기능
    - 한가지 동작에 대해서 연쇄적으로 다른 일 발생

    ```sql
    CREATE OR REPLACE TRIGGER 트리거명
    BEFORE|AFTER INSERT|UPDATE|DELETE ON 테이블{뷰}이름
    BEGIN
        PL/SQL쿼리
    END;
    ```

## 7,8,9일차
- Oracle연동 Python GUI 프로그램 개발
    - [오라클연동](./toyproject/README.md)

## 10일차
- HR SQL연습
- 코딩테스트 진행
    