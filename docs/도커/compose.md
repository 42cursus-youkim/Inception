# 컴포즈

### `service "mariadb" is not running container #1`

- `--project-name`을 빼먹지 말자...


## 볼륨

### 설정에 대해 알아보자
```yaml
mysql:
  driver: local # 기본값
  driver_opts:
    type: none # 가상 파일시스템
    o: bind # 옵션: 바인드
    device: ${VOLUME_ROOT}/mysql # 경로
```

- [리눅스 도커의 `local` 드라이버는 `mount`와 비슷한 옵션 지원](https://docs.docker.com/engine/reference/commandline/volume_create/#driver-specific-options)
- [`type: none`은 가상 파일시스템이라는 뜻](https://unix.stackexchange.com/a/136689)
- https://linuxhint.com/docker_volumes_mounting/
- https://stackoverflow.com/a/52815759/13503626
- [bind mount란? (symlink같은데 파일시스템 단위로)](https://unix.stackexchange.com/a/629934)
- [bind mount란? (복잡하다)](https://unix.stackexchange.com/a/198591)


### 도대체 몰겠는 에러

```bash
Error response from daemon: failed to mount local volume: mount /home/youkim/data/mysql:/home/youkim/.local/share/docker/volumes/inception_db/_data, flags: 0x1000: no such file or directory
make: *** [Makefile:17: up] Error 1
```

- 놀랍게도 `volumes`에서는 `~`가 치환되지 않음
- 꺄아악

## 네트워크

### 도커에서 `bridge`란

- 컨테이너들을 동일 브리지 네트워크에 연결, 연결된 컨테이너끼리만 통신 가능

### 네트워크 드라이버들

- `bridge`: 기본값
- `host`: 호스트 머신의 네트워크를 사용
- `overlay`: 여러 도커 데몬의 네트워크 연결

[참고자료](https://docs.docker.com/network/#network-drivers)
