FROM phusion/baseimage:0.9.18
MAINTAINER snoopy <info@medved.in>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
RUN apt-get update
RUN apt-get -y install git gcc make zlib1g-dev libmp3lame-dev libmad0-dev libpng12-dev libjpeg8-dev
RUN mkdir /tmp/lms
RUN  perl -v
RUN apt-get -f -y install perl=5.18.2-2ubuntu1

#RUN git clone https://github.com/Logitech/slimserver-vendor.git  /tmp/lms
#RUN chmod +x /tmp/lms/CPAN/buildme.sh
#RUN /tmp/lms/CPAN/buildme.sh
COPY install.sh /tmp/
RUN chmod +x /tmp/install.sh; sync; /tmp/install.sh; sync; rm /tmp/install.sh

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################
VOLUME /config /music
EXPOSE 3483 3483/udp 9000 9090