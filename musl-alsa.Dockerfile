FROM messense/rust-musl-cross:aarch64-musl-arm64

RUN VERS=1.2.8 \
    && cd /home/rust/libs \
    && curl -LO https://www.alsa-project.org/files/pub/lib/alsa-lib-${VERS}.tar.bz2 \
    && tar xf alsa-lib-${VERS}.tar.bz2 && cd alsa-lib-${VERS} \
    && CC=${TARGET_CC} \
    ./configure --enable-shared=no --enable-static=yes \
    --prefix=${TARGET_HOME} \
    --host=${RUST_MUSL_CROSS_TARGET} \
    && make && make install \
    && cd .. && rm -rf alsa-lib-${VERS}.tar.bz2 alsa-lib-${VERS} \
    && apt-get update && apt-get install -y pkg-config
