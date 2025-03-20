## 토이프로젝트
Python GUI - Oracle연동 프로그램

### GUI 프레임워크
- GUI 프레임워크 종류
    1. tkinter
        - 파이썬 내장된 GUI 라이브러리, 중소형 프로그램 사용. 간단하게 사용가능. 안이쁨
    2. **PyQt** / PySide
        - C / C++에서 사용하는 GUI프레임워크 Qt를 파이썬에 사용하게 만든 라이브러리. 현재 6버전 출시. 유료
        - PyQt의 사용라이선스 문제로 PySide 출시 PyQt에서 PySide로 변경하는데 번거로움
        - tkinter보다 난이도 있음
        - 아주 이쁨, QtDesigner툴로 포토샵처럼 GUI 디자인 가능
        - Python GUI중에서 가장 많이 사용되는 라이브러리
    3. Kivy
        - OpenGL(게임엔진용 3D 그래픽엔진)으로 구현되는 GUI 프레임워크
        - 안드로이드, IOS 등 모바일용으로도 개발 가능
        - 최신 기술이라 아직 불안정
    4. wxPython
        - Kivy처럼 멀티플랫폼 GUI 프레임워크
        - 어려움

### PyQt5 GUI 사용
- PyQt5 설치
    - 콘솔에서 `> pip install PyQt5`

- QtDesigner 설치
    - https://build-system.fman.io/qt-designer-download 다운로드 후 설치
    <img src = "../image/db005.png" width = 600>

### PyQt5 개발
1. PyQt 모듈 사용 윈앱 만들기
2. 윈도우 기본설정
3. PyQt 위젯 사용법(레이블, 버튼, ...)
4. 시그널(이벤트) 처리 방법
5. QtDesigner로 화면 디자인, PyQt와 연동
<img src = "../image/db004.png" width = 600>

#### Oracle연동 GUI개발 시작
- 오라클 Python연동 DB(스키마) 생성
    ```sql
    -- sys(sysdba)로 작업
    -- madang 스키마, 사용자 생성
    CREATE USER madang IDENTIFIED BY madang;

    -- 권한 설정
    GRANT CONNECT, resource TO madang;

    -- madang으로 사용 스키마 변경

    -- 테이블 Student 생성
    CREATE TABLE students (
        std_id NUMBER PRIMARY KEY,
        std_name varchar2(100) NOT NULL,
        std_mobile varchar2(15) NULL,
        std_regyear number(4, 0) NOT NULL
    );

    -- Students용 시퀀스 생성
    CREATE SEQUENCE SEQ_STUDENT
        INCREMENT BY 1 -- 숫자를 1씩 증가
        START WITH 1; -- 1부터 숫자가 증가됨
    ```
- Student 테이블 생성, 더미데이터 추가
    ```sql
    -- madang 로그인

    -- 조회
    SELECT * FROM students;

    -- 더미데이터 삽입
    INSERT INTO students (std_id, std_name, std_mobile, std_regyear)
    VALUES (seq_student.nextval, '홍길동', '010-9999-8888', 1997);

    INSERT INTO students (std_id, std_name, std_mobile, std_regyear)
    VALUES (seq_student.nextval, '홍길순', '010-9999-8877', 2000);
    ```
- Python 오라클 연동 테스트
    - 오라클 모듈
        - oracledb - 오라클 최선버전에 매칭
        - **cx_Oracle** - 구버전까지 잘 됨
    - Microsoft C++ Build Tools 필요 [Microsoft C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)
        - Visual Studio Installer 실행
        - 개별 구성요소에서 아래 요소 선택
            - [x] MVSC V1XX - VS 20XX C++ x64/x86 빌드 도구
            - [x] C++ CMake Tools for Window
            - [x] Window 10 SDK(10.0.xxxxx)
        - 설치
    - 콘솔에서 `> pip install cx_Oracle`
    - 콘솔 오라클 연동 : [python](./)
        - DIP-1047 오류 발생
        - 64-bit Oracle Client Library가 OS에 설치되지 않았기 때문에 발생하는 현상
        - 아래 사이트에서 버전에 맞는 Oracle Client를 다운로드
        - https://www.oracle.com/kr/database/technologies/instant-client/winx64-64-downloads.html
        - 11g 다운로드
        - 압축해제(C:\DEV\Tool\instantclient_11_2), 실행창에 'sysdm.cpl', 시스템속성 > 고급 > 환경변수 > 시스템 변수 > Path(C:\DEV\Tool\instantclient_11_2) 등록
        - 재부팅
    - 콘솔 테스트 결과
        <img src = '../image/db006.png' width = 600>
- QtDesigner로 화면 구성
- PyQt로 Oracle 연동 CRUD 구현

