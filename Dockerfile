FROM ubuntu:18.04
MAINTAINER Ke Zhang <plutino@gmail.com>

RUN apt-get -y update && apt-get -y upgrade && apt-get -y clean
RUN apt-get -y install sane sane-utils ghostscript netpbm x11-common- && apt-get -y clean

ADD drivers /opt/brother/docker_skey/drivers
RUN dpkg -i /opt/brother/docker_skey/drivers/*.deb

ADD config /opt/brother/docker_skey/config
ADD scripts /opt/brother/docker_skey/scripts

RUN cfg=`ls /opt/brother/scanner/brscan-skey/brscan-skey-*.cfg`; ln -sfn /opt/brother/docker_skey/config/brscan-skey.cfg $cfg

ENV SCANNER_NAME="Brother"
ENV SCANNER_MODEL="MFC-L2700W"
ENV SCANNER_IP_ADDRESS="192.168.0.160"

#VOLUME /scans
CMD /opt/brother/docker_skey/scripts/start.sh
