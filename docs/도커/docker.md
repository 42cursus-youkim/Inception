# 도커

## 용어 정리

### `attach`
- `stdin`, `stdout`, `stderr` 를 실행 중인 컨테이너에 연결하기
## 인자 옵션

### `-d, --detach`
- 백그라운드 프로세스로 실행한다
- 몬?가 스레드 detach랑 비슷한 느낌

### `-t, --tty`
- 터미널에서 입력할 수 있다

### `-i, --interactive`
- 사용자 입력을 사용하기
- `attach` 상태가 아니여도 쓸 수 있다!

- `docker run -it` 모드로 실행해야 터미널에서 직접 실행 가능!
- 도커 컴포즈에서는
  - `stdin_open: true` 가 `-i`
  - `tty: true` 가 `-t`

## `Port` vs `Expose`

### `Port`

- 호스트에서 접근 가능한 포트를 열기
- `호스트 포트:컨테이너 포트`: 지정 호스트 포트를 통해 접근 가능
- `컨테이너 포트`: 무작위 호스트 포트가 지정됨

### `Expose`

- 컨테이너끼리만 접근 가능한 포트를 열기
- 호스트에서는 접근할 수 없다

## `sudo` 치는 거는 너무 힘들어

- 도커의 시스템 권한을 분리해서 `sudo` 없이 도커를 돌리자
- 도커 자체는 `root` 권한으로 돌아간다!

[공식 문서](https://docs.docker.com/engine/security/rootless/)

1. 도커를 끈다

```bash
sudo systemctl disable --now docker.service docker.socket
```

2. rootless 툴 실행

```bash
/usr/bin/dockerd-rootless-setuptool.sh install
```

이런 오류가 났다면 그대로 따라해주고 다시 시도하기
```bash
[ERROR] Missing system requirements. Run the following commands to
[ERROR] install the requirements and run this tool again.

########## BEGIN ##########
sudo sh -eux <<EOF
# Install newuidmap & newgidmap binaries
apt-get install -y uidmap
EOF
########## END ##########
```

3. 설치가 완료되면 아래 명령어로 실행
```bash
systemctl --user start docker
```

4. 시스템 시작시 실행시 데몬을 실행하기
```bash
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)
```

[스택오버플로우](https://stackoverflow.com/a/40801773/13503626)
[명령어 정리](https://velog.io/@jjewqm/도커-명령어-정리)
