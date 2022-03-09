run an image detached, kill it and remove it
```bash
$ docker run -t -d --name geodjango osgeo/gdal
1ef514b8a1b0c40ccc9453c9147649afbdf9720bb65bac871b1e996a8a00b5a7
$ docker ps -a
CONTAINER ID   IMAGE        COMMAND       CREATED         STATUS         PORTS     NAMES
1ef514b8a1b0   osgeo/gdal   "/bin/bash"   3 seconds ago   Up 2 seconds             geodjango
$ docker kill geodjango
geodjango
$ docker ps -a
CONTAINER ID   IMAGE        COMMAND       CREATED          STATUS                      PORTS     NAMES
1ef514b8a1b0   osgeo/gdal   "/bin/bash"   13 seconds ago   Exited (137) 1 second ago             geodjango
$ docker rm geodjango 
geodjango
$ docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

open a running docker file and enter it (like ssh-ing into it)
```bash
$ docker run -t -d --name geodjango osgeo/gdal
d5e391a6202396ae67ea8d85b9fe38db2a7b0698da619bc65889fdc96bd9a934
$ docker ps -a 
CONTAINER ID   IMAGE        COMMAND       CREATED         STATUS         PORTS     NAMES
d5e391a62023   osgeo/gdal   "/bin/bash"   3 seconds ago   Up 2 seconds             geodjango
$ docker exec -it geodjango bash
```

copy files over from local to container:
```bash
$ docker cp somefolderorfile container-name:some/destination
```