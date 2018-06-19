# Build

```sh
$ git clone https://github.com/BienTrinh/psono.git
# cd psono
$ docker network create backend
$ docker network create outside
$ vi settings.yaml  change database postgres information
$ vi vhost.conf  change domains information
```

- Use openssl generate server.key, server.crt for match YOURDOMAIN.COM

# Run

```sh
$ docker-compose up -d
```

# Stop

```sh
$ docker-compose stop && docker-compose rm -f
```
Notes: Use https://www.YOURDOMAIN.COM/server/ for backend-server login
