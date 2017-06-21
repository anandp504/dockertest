# dockertest

This project is built from Centos 7.3.1611

## Compiling

To build the project, run the following command from the root of the project:

```
sbt> compile
```

## Publishing to local docker

```
sbt> docker:publishLocal
```

## Running within the docker container

```
docker run -it <IMAGE_ID> /opt/docker/bin/dockertest-app
```

## Login to the bash shell of the container. This will login as root user

```
docker run -it <IMAGE_ID> /bin/bash
```

## Check Centos version

```
docker run -it <IMAGE_ID> cat /etc/redhat-release
```
