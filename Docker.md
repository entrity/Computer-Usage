## Commands
```bash
docker ps # Show containers
docker image ls
docker commit $CONTAINER $NAME[:$TAG] # Save a snapshot of the container
docker run -it $IMAGE bash
docker exec -it $CONTAINER bash
# Clean up exited containers
docker ps -a -f status=exited | cut -d\  -f1 | grep -v CONTAINER | xargs docker rm
```

### Registries

```bash
# Pull from registry
docker pull reg/image:tag
# Push to private registry
docker tag image:tag reg/image:tag
docker push reg/image:tag
# NB: after pushing a change to the registry, enter Jenkins and pull that change (if using Jenkins)!
```

## Running GUI programs on Docker
See http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/

> There are a few different options to run GUI applications inside a Docker container like using [SSH with X11 forwarding](http://blog.docker.com/2013/07/docker-desktop-your-desktop-over-ssh-running-inside-of-a-docker-container/), or [VNC](http://stackoverflow.com/a/16311264) but the simplest one that I figured out was to share my X11 socket with the container and use it directly.
> ```
> docker run -ti --rm \
>   -e DISPLAY=$DISPLAY  \
>   -v /tmp/.X11-unix:/tmp/.X11-unix \
>   firefox
> ```

## Installing Docker without root
Not possible, as far as I know: https://stackoverflow.com/a/48474153/507721

## Launch container [doc](https://docs.docker.com/engine/reference/commandline/run/)
```bash
# docker run -it -v <mount-share> <image> <command>
# -i is 'interactive'
# -t is 'allocate pseudo-tty'
# CPU e.g.
docker run -it -v /sharedfolder:/root/sharedfolder ufoym/deepo bash
# GPU e.g.
nvidia-docker run -it -v /sharedfolder:/root/sharedfolder ufoym/deepo bash
```

## Commit image changes [doc](https://docs.docker.com/engine/reference/commandline/commit/)

After installing something new, you can easily commit your current images so that you can freely share with others or launch it again.
```bash
docker ps # Get container ID
docker commit <container> [repository:[tag]]
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE4NTgyMDYzOTUsLTEzOTkyNzM1NDIsLT
U2OTM5NDE5MF19
-->
