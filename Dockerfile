FROM alpine:latest

ARG DOWNLOAD_URL=https://www.mumble.info/downloads/linux-static-server

RUN apk add --no-cache wget gettext && \
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

COPY murmur.ini.template /etc/murmur.ini.template
COPY entrypoint.sh /entrypoint.sh

ENV DATABASE=murmur.sqlite \
    DB_DRIVER=QSQLITE \
    DB_USERNAME= \
    DB_PASSWORD= \
    DB_HOST= \
    DB_PORT= \
    DB_PREFIX= \
    DB_OPTS= \
    DBUS=session \
    DBUSSERVICE=net.sourceforge.mumble.murmur \
    ICE="\"tcp -h 127.0.0.1 -p 6502\"" \
    ICESECRETREAD= \
    ICESECRETWRITE= \
    GRPC="\"127.0.0.1:50051\"" \
    GRPCCERT="\"\"" \
    GRPCKEY="\"\"" \
    LOGFILE=murmur.log \
    PIDFILE= \
    WELCOMETEXT="\"<br />Welcome to this server running <b>Murmur</b>.<br />Enjoy your stay!<br />\"" \
    PORT=64738 \
    HOST= \
    SERVERPASSWORD= \
    BANDWIDTH=72000 \
    TIMEOUT=30 \
    USERS=100 \
    USERSPERCHANNEL=0 \
    MESSAGEBURST=5 \
    MESSAGELIMIT=1 \
    ALLOWPING=true \
    OPUSTHRESHOLD=100 \
    CHANNELNESTINGLIMIT=10 \
    CHANNELCOUNTLIMIT=1000 \
    CHANNELNAME="[ \\\\-=\\\\w\\\\#\\\\[\\\\]\\\\{\\\\}\\\\(\\\\)\\\\@\\\\|]+" \
    USERNAME="[-=\\\\w\\\\[\\\\]\\\\{\\\\}\\\\(\\\\)\\\\@\\\\|\\\\.]+" \
    DEFAULTCHANNEL=0 \
    REMEMBERCHANNEL=true \
    TEXTMESSAGELENGTH=5000 \
    IMAGEMESSAGELENGTH=131072 \
    ALLOWHTML=true \
    LOGDAYS=31 \
    REGISTER_NAME="Mumble Server" \
    REGISTER_PASSWORD=secret \
    REGISTER_URL=http://www.mumble.info/ \
    REGISTER_HOSTNAME= \
    REGISTER_LOCATION= \
    BONJOUR=True \
    SSL_CERT= \
    SSL_KEY= \
    SSL_PASS_PHRASE= \
    SSL_C_A= \
    SSL_D_H_PARAMS=@ffdhe2048 \
    SSL_CIPHERS=EECDH+AESGCM:EDH+aRSA+AESGCM:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA:AES256-SHA:AES128-SHA \
    UNAME= \
    OBFUSCATE=false \
    CERTREQUIRED=False \
    SENDVERSION=True \
    SUGGEST_VERSION= \
    SUGGEST_POSITIONAL= \
    SUGGEST_PUSH_TO_TALK= \
    LEGACY_PASSWORD_HASH=false \
    KDF_ITERATIONS=-1 \
    AUTOBAN_ATTEMPTS=10 \
    AUTOBAN_TIMEFRAME=120 \
    AUTOBAN_TIME=300 \
    ICE_WARN_UNKNOWN_PROPERTIES=1 \
    ICE_MESSAGE_SIZE_MAX=65536

ENTRYPOINT [ "/entrypoint.sh" ]

WORKDIR /var/lib/murmur
EXPOSE 64738/tcp 64738/udp 50051
USER murmur

CMD /var/lib/murmur/murmur.x86 -fg -ini /var/lib/murmur/murmur.ini
