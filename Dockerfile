FROM alpine:latest

ARG DOWNLOAD_URL=https://www.mumble.info/downloads/linux-static-server

RUN apk add --no-cache wget && \
    wget -O /tmp/murmur.tar.bz2 $DOWNLOAD_URL && \
    cd /tmp && \
    tar xvf murmur.tar.bz2 && \
    mv murmur-static* murmur && \
    mv murmur /var/lib && \
    rm /var/lib/murmur/README && \
    rm -rf /tmp/* && \
    apk del wget && \
    adduser --disabled-password murmur && \
    chown -R murmur /var/lib/murmur

WORKDIR /var/lib/murmur
EXPOSE 64738/tcp 64738/udp 50051
USER murmur

CMD /var/lib/murmur/murmur.x86 -fg -ini /var/lib/murmur/murmur.ini