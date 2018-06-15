#Build

```sh
$ git clone https://github.com/BienTrinh/psono.git
# cd psono
$ docker build -t "psono-backend" .
$ vi settings.yaml  change database postgres information
```

- Use openssl generate server.key, server.crt for match YOURDOMAIN.COM

# Run

```sh
$ docker run --rm --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /path/to/settings.yaml:/home/psono/.psono_server/settings.yaml --name poc -p443:443 --name psono-server -d psono-backend
$ docker exec -it psono-server bash
$ su - psono 
$ python3 ~/psono-server/psono/manage.py migrate
$ python3  ~/psono-server/psono/manage.py createuser toor@YOURDOMAIN.COM change_me toor@YOURDOMAIN.COM
$ python3 ~/psono-server/psono/manage.py promoteuser toor@YOURDOMAIN.COM superuser

$ docker run --name psono-client -d -p 10101:80 psono/psono-client:latest
$ docker run --name psono-admin-client -d -p 10102:80 psono/psono-admin-client:latest
$ docker ps
```
Notes: Use https://www.YOURDOMAIN.COM/server/ for backend-server login
