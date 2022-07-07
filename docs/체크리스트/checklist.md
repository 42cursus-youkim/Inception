# 목록

- [x] [`docker-compose` 쓰기](docker-compose.md)
  - [x] **볼륨**
    - [x] 위치는 `/home/login/data`
    - [x] `WordPress DB` 볼륨
    - [x] `WordPress 웹사이트 파일` 볼륨

  - [x] **network**
    - [x] `docker-network` 네트워크
    - [x] `network: host, --link, links:` 사용 금지

  - [x] 컨테이너는 문제시 자동 재시작해야댐
  - [x] `tail -f` 사용 금지
  - [x] 무한 루프 명령어 (`tail -f, bash, sleep infinity, while true`)로 실행이 시작되면 안됨 (entrypoint 등)
  - [x] `PID 1`에 대해 공부하자

- [x] [**서비스**](service.md)
  - [x] 이미지 이름이 해당하는 서비스명과 같아야댐
  - [x] 전용 컨테이너에서 실행되야댐
  - [x] 알파인 리눅스 두번쨰 안정판 (3.15.4) 컨테이너에서 실행되야댐
  - [x] `Dockerfile`을 하나씩 가져야댐
  - [x] `NGINX`의 443 포트를 통해서만 접속이 가능해야댐 (`TLSv1.2` 또는 `TLSv1.3`으로)

  - [x] **Dockerfile**
    - [x] `Makefile`에서 부른 `docker-compose.yml`에서 `Dockerfile`을 실행해야댐
    - [x] `Dockerfile`은 직접 작성해야댐 (예외는 `Alpine/Debian`)
    - [x] `latest` 태그 금지
    - [x] 비밀번호가 있어서는 안됨
    - [x] `.env`에 환경 변수 담기 추천

  - [x] **NGINX**
    - [x] `TLSv1.2` 또는 `TLSv1.3`만 있어야댐

  - [ ] **WordPress + php-fpm**
    - [x] `NGINX` 없어야댐
    - [ ] 사용자는 **2명** (일반 1명, 관리자 1명)
    - [ ] 관리자 사용자명에 `admin/Admin/administrator/Administrator`이 있어선 안댐

  - [x] **MariaDB**
    - [x] `NGINX` 없어야댐

- [x] 도메인명은 `login.42.fr`
  - [x] 웹사이트 주소로 리다이렉트되어야 함

```bash
scarf@scarf-VirtualBox:~/Repo/inception$ cat /etc/hosts
127.0.0.1       localhost
127.0.1.1       scarf-VirtualBox
127.0.0.1       youkim.42.fr

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

- [x] 껐다 켜도 볼륨에 정보가 남아있어야함
  - [x] `make reload` 해도 댓글이 남아있음
