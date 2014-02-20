Docker Skype
============

Run Skype in a docker container and avoid cluttering the host with multi-arch setup

```
docker build -t DESIRED_IMAGE_NAME .
docker run -d -P DESIRED_IMAGE_NAME
```

Then use `docker ps` to find the port that SSH is nat'ed to, and `ifconfig` to get the IP address, then start skype and forward X to your normal desktop.
`ssh -X docker@IP -p PORT skype` password will be docker.
