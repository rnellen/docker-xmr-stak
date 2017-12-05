FROM  alpine:latest

RUN adduser -S -D -H -h /home app

RUN apk --no-cache upgrade \
 && apk --no-cache add \
      cmake libuv-dev build-base curl \
      openssh git nodejs 

# Install dumb-init (avoid PID 1 issues). https://github.com/Yelp/dumb-init
RUN curl -Lo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 \
 && chmod +x /usr/local/bin/dumb-init 

# Grant privileges
RUN chgrp -R 0     /var /etc /home \
 && chmod -R g+rwX /var /etc /home \ 
 && chmod 664 /etc/passwd /etc/group

WORKDIR /home

# XMRIG
RUN git clone https://github.com/xmrig/xmrig \
 && cd xmrig \
 && mkdir build \
 && cmake -DCMAKE_BUILD_TYPE=Release . \
 && make
 
RUN apk del build-base cmake 

USER app
WORKDIR /home/xmrig
ENTRYPOINT  ["dumb-init","./xmrig"]
CMD ["--help"]
