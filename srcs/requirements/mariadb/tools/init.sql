USE mysql;  -- mysql 데이터베이스를 사용
FLUSH PRIVILEGES; -- 사용자 추가, 삭제 등 변경 사항을 즉시 반영

DROP DATABASE test; -- test 데이터베이스 삭제
DELETE FROM mysql.user WHERE User=''; -- user 테이블에서 빈 유저 삭제
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user -- user 테이블에서 삭제
  WHERE User='root'  -- 대상은 아래 호스트명이 아닌 root 유저
  AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' -- root@localhost에 대한 수정
  IDENTIFIED BY '${DB_ROOT_PASSWORD}'; -- 비밀번호 변경

CREATE DATABASE ${DB_NAME} -- 새로운 DB 생성
  CHARACTER SET utf8 -- 문자셋은 utf8 (기본값: latin1)
  COLLATE utf8_general_ci; -- 정렬 방식은 utf8_general_ci

CREATE USER '${DB_USER}'@'%' -- 아무 호스트로 접속 가능한 유저 생성
  IDENTIFIED by '${DB_PASSWORD}'; -- 비밀번호 변경

GRANT ALL PRIVILEGES -- GRANT OPTION과 PROXY 권한을 제외한 모든 권한 부여
  ON ${DB_NAME}.* -- 객체명
  TO '${DB_USER}'@'%'; -- 권한을 부여받는 사용자

FLUSH PRIVILEGES;
