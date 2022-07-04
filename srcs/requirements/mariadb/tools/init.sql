USE mysql;  -- mysql 데이터베이스를 사용

-- 테스트 데이터베이스 제거
DROP DATABASE test;
DELETE FROM mysql.db -- mysql 데이터베이스의 db 테이블
  WHERE Db='test' OR Db='test\\_%'; -- test 데이터베이스에 대한 권한 삭제
FLUSH PRIVILEGES; -- 권한 반영

-- 익명 사용자 제거
DELETE FROM mysql.user
  WHERE User=''; -- 익명 유저 삭제

-- 원격 root 접근 제거
DELETE FROM mysql.user
  WHERE User='root'  -- 대상은 아래 호스트명이 아닌 root 유저
  AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- root 비밀번호 변경
ALTER USER 'root'@'localhost' -- root@localhost에 대한 수정
  IDENTIFIED BY '${DB_ROOT_PASSWORD}'; -- 비밀번호 변경

-- wordpress 데이터베이스 생성
CREATE DATABASE ${DB_NAME} -- 새로운 DB 생성
  CHARACTER SET utf8 -- 문자셋은 utf8 (기본값: latin1)
  COLLATE utf8_general_ci; -- 정렬 방식은 utf8_general_ci

-- wordpress 유저 생성
CREATE USER '${DB_USER}'@'%' -- 아무 호스트로 접속 가능한 유저 생성
  IDENTIFIED by '${DB_PASSWORD}'; -- 비밀번호 변경

-- wordpress 유저 권한 부여
GRANT ALL PRIVILEGES -- GRANT OPTION과 PROXY 권한을 제외한 모든 권한 부여
  ON ${DB_NAME}.* -- 객체명
  TO '${DB_USER}'@'%'; -- 권한을 부여받는 사용자

FLUSH PRIVILEGES;
