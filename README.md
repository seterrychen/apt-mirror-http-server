# apt-mirror-http-server

Base on Ubuntu, using Docker to construct your Apt mirror HTTP server

## Usage
```
docker run -d -P port_number:80 -v /path/your_mirror.list:/etc/apt/ seterrychen/apt-mirror-http-server
```

If you don't provide mirror.list file, the program will use default setting. 
It will take time to download, then start http server. Using ``docker logs -f container-id`` to check the process.
