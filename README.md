Docker Skype
============

Run Skype in a docker container and avoid cluttering the host with multi-arch
setup.

1. Build the container's image directly from github
   `docker build --rm=true -t DESIRED_NAME https://raw.github.com/shofetim/docker-skype/master/Dockerfile`

2. Run container
   `docker run -d -P DESIRED_NAME`

3. Get the port that SSH is nat'ed to.
   `docker ps`
   
4. Get the IP address.
   `ifconfig`

5. Run skype with X forwarded to your normal desktop
   `ssh -X docker@IP -p PORT skype` password will be docker.

