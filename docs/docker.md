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

### `service "mariadb" is not running container #1`
- `docker run -it` 모드로 실행해야 터미널에서 직접 실행 가능!
- 도커 컴포즈에서는
  - `stdin_open: true` 가 `-i`
  - `tty: true` 가 `-t`
- 꺄아악 여전히안댐
## `Port` vs `Expose`

### `Port`

- 호스트에서 접근 가능한 포트를 열기
- `호스트 포트:컨테이너 포트`: 지정 호스트 포트를 통해 접근 가능
- `컨테이너 포트`: 무작위 호스트 포트가 지정됨

### `Expose`

- 컨테이너끼리만 접근 가능한 포트를 열기
- 호스트에서는 접근할 수 없다


[스택오버플로우](https://stackoverflow.com/a/40801773/13503626)
[명령어 정리](https://velog.io/@jjewqm/도커-명령어-정리)
