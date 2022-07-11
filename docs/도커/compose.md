# 컴포즈

### `service "mariadb" is not running container #1`

- `--project-name`을 빼먹지 말자...

### 볼륨 관련 에러

```bash
Error response from daemon: failed to mount local volume: mount /home/youkim/data/mysql:/home/youkim/.local/share/docker/volumes/inception_db/_data, flags: 0x1000: no such file or directory
make: *** [Makefile:17: up] Error 1
```

- 놀랍게도 `volumes`에서는 `~`가 치환되지 않음
- 꺄아악
