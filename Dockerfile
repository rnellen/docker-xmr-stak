###
# Build image
###
#FROM alpine:edge AS build
FROM alpine:edge

ENV XMR_STAK_VERSION v2.0.0

COPY app /app

WORKDIR /usr/local/src

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> //etc/apk/repositories
RUN apk add --no-cache \
      libmicrohttpd-dev \
      openssl-dev \
      hwloc-dev@testing \
      build-base \
      cmake \
      coreutils \
      git

RUN git clone git@github.com:fireice-uk/xmr-stak.git \
    && cd xmr-stak \
    && git checkout -b build ${XMR_STAK_VERSION} \
    \
    && cmake -CMAKE_BUILD_TYPE=Release \
             -CPU_ENABLE=ON \
             -CUDA_ENABLE=OFF \
             -HWLOC_ENABLE=ON \
             -MICROHTTPD_ENABLE=OFF \
             -OpenCL_ENABLE=OFF \
             -OpenSSL_ENABLE=ON \
             -WIN_UAC=OFF \
             -XMR-STAK_COMPILE=native \
             -XMR-STAK_CURRENCY=monero \
             -CMAKE_LINK_STATIC=ON . \
    && make -j$(nproc) \
    \
    && cp -t /app bin/xmr-stak config.txt \
    && chmod 777 -R /app
RUN apk del --no-cache --purge \
      libmicrohttpd-dev \
      openssl-dev \
      hwloc-dev@testing \
      build-base \
      cmake \
      coreutils \
      git || echo "apk purge error ignored"

###
# Deployed image
###
#FROM alpine:edge

WORKDIR /app

#RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> //etc/apk/repositories
RUN apk add --no-cache \
      libmicrohttpd \
      openssl \
      hwloc@testing \
      python2 \
      py2-pip \
    && pip install envtpl

#COPY --from=build app .

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["xmr-stak"]
