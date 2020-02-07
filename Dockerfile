FROM debian:stretch-backports

RUN apt-get update

RUN apt-get install -y libmicrohttpd-dev libjansson-dev \
	libssl-dev libsrtp-dev libsofia-sip-ua-dev libglib2.0-dev \
	libopus-dev libogg-dev libcurl4-openssl-dev liblua5.3-dev \
	libconfig-dev pkg-config gengetopt libtool automake gtk-doc-tools git

RUN apt-get install -y libwebsockets-dev wget make python3-pip ninja-build

RUN pip3 install meson

RUN wget http://ftp.gnome.org/pub/gnome/sources/glib/2.63/glib-2.63.5.tar.xz

RUN tar xfv glib-2.63.5.tar.xz && cd glib-2.63.5 && meson _build && ninja -C _build && ninja -C _build install

RUN git clone https://gitlab.freedesktop.org/libnice/libnice

RUN cd libnice && ./autogen.sh && ./configure --prefix=/usr && make && make install


RUN wget https://github.com/cisco/libsrtp/archive/v2.2.0.tar.gz

RUN tar xfv v2.2.0.tar.gz && cd libsrtp-2.2.0 && ./configure --prefix=/usr --enable-openssl && make shared_library && make install

RUN git clone https://github.com/meetecho/janus-gateway.git

RUN cd janus-gateway && sh autogen.sh && ./configure --prefix=/opt/janus --disable-rabbitmq --disable-mqtt && make && make install

RUN cd janus-gateway && make configs

EXPOSE 8088
EXPOSE 8089

CMD [ "/opt/janus/bin/janus"]