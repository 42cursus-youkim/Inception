# 수동 로그

```sql

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| test               |
+--------------------+
5 rows in set (0.003 sec)

MariaDB [(none)]> drop database test;
Query OK, 0 rows affected (0.014 sec)

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.002 sec)

MariaDB [(none)]> select Db from mysql.db;
+---------+
| Db      |
+---------+
| test    |
| test\_% |
+---------+
2 rows in set (0.001 sec)

MariaDB [(none)]> DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
Query OK, 1 row affected (0.007 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> select Db from mysql.db;
Empty set (0.001 sec)

```
