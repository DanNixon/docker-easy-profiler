FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      cmake \
      curl \
      g++ \
      git \
      make \
      qt5-default \
      libqt5svg5 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG VERSION=2.0.1

RUN curl \
      --location \
      --output '/tmp/easy_profiler.tar.gz' \
      "https://github.com/yse/easy_profiler/archive/v$VERSION.tar.gz" && \
    tar xzfv '/tmp/easy_profiler.tar.gz' && \
    mkdir -p "/easy_profiler-$VERSION/build" && \
    cd "/easy_profiler-$VERSION/build" && \
    cmake .. && \
    make -j `nproc` && \
    rm -rf /tmp/* /var/tmp/*

ENV PATH=$PATH:/easy_profiler-$VERSION/build/bin
