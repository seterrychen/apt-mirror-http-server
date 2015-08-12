# apt-mirror-http-server

Base on Ubuntu, using Docker to construct your Apt mirror HTTP server

## Usage
Using default [mirror.list!](mirror.list)
```
docker run -v /path/data:/var/spool/apt-mirror \
           -d -p port_number:80 seterrychen/apt-mirror-http-server
```

Using your mirror.list
```
docker run -v /path/data:/var/spool/apt-mirror \
           -v /path/your/mirror.list:/etc/apt/mirror.list \
           -d -p port_number:80 seterrychen/apt-mirror-http-server
```

## Note
It will take time to download, then start http server. Using ``docker logs -f container-id`` to check the process.
