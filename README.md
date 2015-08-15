# apt-mirror-http-server

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

If you don't setting variable of mirror.list and TIMEOUT, it will using the default [mirror.list](mirror.list), and
the default TIMEOUT is 6 hours. To see the [TIMEOUT format description](http://www.cyberciti.biz/faq/linux-unix-sleep-bash-scripting/)

## Note
It will take time to download, then start http server. Using ``docker logs -f container-id`` to check the process.
