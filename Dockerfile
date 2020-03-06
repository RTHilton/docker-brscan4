FROM ubuntu:18.04
LABEL authors="Ryan T. Hilton"

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y clean && \
	apt-get -y install \
	git \
	make \
	gcc \
	nano \
	img2pdf \
	ocrmypdf \
	zlib1g \
	zlib1g-dev && \
	apt-get -y clean

RUN cd /tmp && \
	git clone https://github.com/rthilton/brother-scand && \
    cd brother-scand && \
	git clone https://github.com/darsto/cber ber && \
    sed -i -e 's/HOST=%s:%d/HOST=192.168.0.155:%d/g' device_handler.c && \
    sed -i -e 's/local_ip, BUTTON_HANDLER_PORT,/BUTTON_HANDLER_PORT,/g' device_handler.c && \
    make && \
    mkdir -p /opt/brother-scand/bin && \
    cp build/brother-scand /opt/brother-scand/bin/brother-scand && \
	mkdir -p /opt/brother-scand/config && \
    cp out/brother.config /opt/brother-scand/config/brother.config && \
    cd /opt/brother-scand/config && \
    sed -i -e 's/10.0.0.144/192.168.0.160/g' brother.config && \
    sed -i -e 's/scan.func IMAGE .\/scanhook.sh/scan.func IMAGE \/opt\/brother-scand\/scripts\/scan2image.sh/g' brother.config && \
#   sed -i -e 's/#scan.func OCR .\/otherhook.sh second_arg third_arg/scan.func OCR  \/opt\/brother-scand\/scripts\/scan2pdfc.sh/g' brother.config && \
    sed -i -e 's/#scan.func EMAIL .\/scanhook.sh/scan.func EMAIL \/opt\/brother-scand\/scripts\/scan2pdf.sh/g' brother.config && \
    sed -i -e 's/#scan.func FILE .\/scanhook.sh/scan.func FILE \/opt\/brother-scand\/scripts\/scan2pdfc.sh/g' brother.config

ADD scripts /opt/brother-scand/scripts

# Need for ocrmypdf
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

EXPOSE 54921
EXPOSE 54925/udp

#VOLUME /scans
CMD /opt/brother-scand/scripts/start.sh
