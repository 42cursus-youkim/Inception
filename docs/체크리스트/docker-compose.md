# `Docker-Compose`

## 볼륨

### 위치는 `/home/login/data`
```bash
scarf@scarf-VirtualBox:~/Repo/inception$ ls ~
Desktop    Music     Repo       data
Documents  Pictures  Templates  snap
Downloads  Public    Videos

scarf@scarf-VirtualBox:~/Repo/inception$ ls ~/data
aria_log.00000001  multi-master.info
aria_log_control   mysql
ddl_recovery.log   mysql_upgrade_info
e9aa800c47ab.pid   performance_schema
ib_buffer_pool     sys
ib_logfile0        wordpress
ibdata1            wp
ibtmp1
```

### `WordPress DB` 볼륨
```yaml
volumes:
  - ~/data:/var/lib/mysql
```

### `WordPress 웹사이트 파일` 볼륨
```yaml
volumes:
  - ~/data/wp:/var/www/html
```

  ## **network**
    ## `docker-network` 네트워크
    ## `network: host, --link, links:` 사용 금지

  ## 컨테이너는 문제시 자동 재시작해야댐
  ## `tail -f` 사용 금지
  ## 무한 루프 명령어 (`tail -f, bash, sleep infinity, while true`)로 실행이 시작되면 안됨 (entrypoint 등)
  ## `PID 1`에 대해 공부하자
