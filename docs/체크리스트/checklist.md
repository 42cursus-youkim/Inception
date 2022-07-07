# 목록

- [x] `docker-compose` 쓰기
  - [ ] **볼륨**
    - [ ] 위치는 `/home/login/data`
    - [ ] `WordPress DB` 볼륨
    - [ ] `WordPress 웹사이트 파일` 볼륨

  - [ ] **network**
    - [ ] `docker-network` 네트워크
    - [ ] `network: host, --link, links:` 사용 금지

  - [ ] 컨테이너는 문제시 자동 재시작해야댐
  - [ ] `tail -f` 사용 금지
  - [ ] 무한 루프 명령어 (`tail -f, bash, sleep infinity, while true`)로 실행이 시작되면 안됨 (entrypoint 등)
  - [ ] `PID 1`에 대해 공부하자

- [ ] **서비스**
  - [ ] 이미지 이름이 해당하는 서비스명과 같아야댐
  - [ ] 전용 컨테이너에서 실행되야댐
  - [ ] 알파인 리눅스 두번쨰 안정판 (3.15.4) 컨테이너에서 실행되야댐
  - [ ] `Dockerfile`을 하나씩 가져야댐
  - [ ] `NGINX`의 443 포트를 통해서만 접속이 가능해야댐 (`TLSv1.2` 또는 `TLSv1.3`으로)

  - [ ] **Dockerfile**
    - [ ] `Makefile`에서 부른 `docker-compose.yml`에서 `Dockerfile`을 실행해야댐
    - [ ] `Dockerfile`은 직접 작성해야댐 (예외는 `Alpine/Debian`)
    - [ ] `latest` 태그 금지
    - [ ] 비밀번호가 있어서는 안됨
    - [ ] `.env`에 환경 변수 담기 추천

  - [ ] **NGINX**
    - [ ] `TLSv1.2` 또는 `TLSv1.3`만 있어야댐

  - [ ] **WordPress + php-fpm**
    - [ ] `NGINX` 없어야댐
    - [ ] 사용자는 **2명** (일반 1명, 관리자 1명)
    - [ ] 관리자 사용자명에 `admin/Admin/administrator/Administrator`이 있어선 안댐

  - [ ] **MariaDB**
    - [ ] `NGINX` 없어야댐

- [ ] 도메인명은 `login.42.fr`
  - [ ] 웹사이트 주소로 리다이렉트되어야 함
