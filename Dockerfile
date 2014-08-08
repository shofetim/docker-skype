# ┌────────────────────────────────────────────────────────────────────┐
# │ Docker Skype.                                                      │
# │                                                                    │
# │ Run skype in a Debian multi-arch container, access it via          │
# │ forwarding X over SSH                                              │
# │                                                                    │
# │ `ssh -X docker@LOCAL_IP skype` the password will be docker         │
# ├────────────────────────────────────────────────────────────────────┤
# │ Copyright © 2014 Jordan Schatz                                     │
# │ Copyright © 2014 Noionλabs (http://noionlabs.com)                  │
# ├────────────────────────────────────────────────────────────────────┤
# │ Licensed under the MIT License                                     │
# └────────────────────────────────────────────────────────────────────┘

FROM debian:stable
MAINTAINER Jordan Schatz "jordan@noionlabs.com"

# Setup multiarch
RUN dpkg --add-architecture i386
RUN apt-get update

# We need ssh to access the instance, and wget to download skype
RUN apt-get install -y openssh-server wget

# Create a user
RUN useradd -m -d /home/docker -p `perl -e 'print crypt('"docker"', "aa"),"\n"'` docker

# Install Skype
RUN wget http://download.skype.com/linux/skype-debian_4.3.0.37-1_i386.deb -O /usr/src/skype.deb
RUN dpkg -i /usr/src/skype.deb || true
RUN apt-get install -fy

# Enable X11Forwarding
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config
RUN mkdir -p /var/run/sshd

# Set locale (fix locale warnings)
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :
RUN echo "America/Los_Angeles" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

EXPOSE 22

# Start ssh services.
CMD ["/usr/sbin/sshd", "-D"]
