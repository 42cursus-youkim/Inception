# 도커

## 인자 옵션

### `-d, --detach`
- 백그라운드 모드에서 실행한다

### `-t, --tty`
- 터미널에서 입력할 수 있다

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