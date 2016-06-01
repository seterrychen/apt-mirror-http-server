# apt-mirror-http-server

[![Docker Stars](https://img.shields.io/docker/stars/seterrychen/apt-mirror-http-server.svg)](https://hub.docker.com/r/seterrychen/apt-mirror-http-server/)
[![Docker Pulls](https://img.shields.io/docker/pulls/seterrychen/apt-mirror-http-server.svg)](https://hub.docker.com/r/seterrychen/apt-mirror-http-server/)

Base on Ubuntu, using Docker to construct your Apt mirror HTTP server

## Usage
Running command
```
docker run -v /path/data:/var/spool/apt-mirror \
           -v /path/your/mirror.list:/etc/apt/mirror.list \
           -e TIMEOUT=timeout-value \
           -d -p port_number:80 seterrychen/apt-mirror-http-server
```
/path/data is where to store data, and the TIMEOUT var to repeatedly execute apt-mirror.

If you don't setting variable of mirror.list and TIMEOUT, it will using the [default mirror.list](mirror.list), and
the default TIMEOUT is 12 hours. To see the [TIMEOUT format description](http://www.cyberciti.biz/faq/linux-unix-sleep-bash-scripting/).

Or running command
```
docker run -v /path/data:/var/spool/apt-mirror \
           -e MIRROR_URL=http://tw.archive.ubuntu.com/ubuntu \
           -e TIMEOUT=timeout-value \
           -d -p port_number:80 seterrychen/apt-mirror-http-server
```
MIRROR_URL can used to replace apt sources of [default mirror.list](mirror.list)

## Note
It will take time to download, then start http server. Using ``docker logs -f container-id`` to check the process.
