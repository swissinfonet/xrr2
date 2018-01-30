FROM          alpine:3.7 as build
ENV           GCHGRP_DIR /gchgrp-cpu
ENV           GCHGRP_BUILD_DIR $GCHGRP_DIR/build
RUN           apk --no-cache add build-base cmake curl git libuv-dev
RUN           git clone https://github.com/swissinfonet/xbuild.git $GCHGRP_DIR && cd $GCHGRP_DIR && \
RUN           mkdir $GCHGRP_BUILD_DIR && cd $GCHGRP_BUILD_DIR && \
              cmake .. -DWITH_HTTPD=OFF -DWITH_AEON=OFF -DCMAKE_BUILD_TYPE=Release && make
RUN           mv $GCHGRP_BUILD_DIR/gchgrp /usr/bin/
FROM          alpine:3.7
RUN           apk --no-cache add libuv-dev
COPY          --from=build /usr/bin/gchgrp /usr/bin/
ENTRYPOINT    ["gchgrp"]
