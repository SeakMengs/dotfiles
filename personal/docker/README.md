# Start docker

```sh
docker-compose up -d
```

# Connect to docker terminal and enter mysql

```sh
docker exec -it local_dev_mysql bash
mysql -P 3306 -u root -p
```
