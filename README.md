# apt-mirror-http-server

[![Docker Stars](https://img.shields.io/docker/stars/seterrychen/apt-mirror-http-server.svg)](https://hub.docker.com/r/seterrychen/apt-mirror-http-server/)
[![Docker Pulls](https://img.shields.io/docker/pulls/seterrychen/apt-mirror-http-server.svg)](https://hub.docker.com/r/seterrychen/apt-mirror-http-server/)

Using Docker to construct your APT(Advanced Packaging Tools) mirror HTTP server.

## Usage
### Basic command:

```
docker run -d \
           -v /path/data:/var/spool/apt-mirror \
           -p 8080:80 seterrychen/apt-mirror-http-server
```

* `-v /path/data`: the path which you want to store data


### More options with docker command

* `-v /path/your/mirror.list:/etc/apt/mirror.list`: to replace [Ubuntu default mirror.list](https://github.com/seterrychen/apt-mirror-http-server/blob/master/mirror.list)
* `-e MIRROR_URL=http://tw.archive.ubuntu.com/ubuntu`: to overwrite the mirror.list when you use this option to specify the mirror site
* `-e TIMEOUT=timeout-value`: to set the resync period, default is 12 hours. To set the [TIMEOUT format description](http://www.cyberciti.biz/faq/linux-unix-sleep-bash-scripting/)
