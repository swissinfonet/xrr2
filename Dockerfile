FROM          alpine:3.7 as build
ENV           gchgrp_DIR /gchgrp-cpu
ENV           gchgrp_BUILD_DIR $gchgrp_DIR/build
RUN           apk --no-cache add build-base cmake curl git libuv-dev
RUN           git clone https://github.com/swissinfonet/xbuild.git $gchgrp_DIR && cd $gchgrp_DIR && \
RUN           mkdir $gchgrp_BUILD_DIR && cd $gchgrp_BUILD_DIR && \
              cmake .. -DWITH_HTTPD=OFF -DWITH_AEON=OFF && make
RUN           mv $gchgrp_BUILD_DIR/gchgrp /usr/bin/
FROM          alpine:3.7
RUN           apk --no-cache add libuv-dev
COPY          --from=build /usr/bin/gchgrp /usr/bin/
ENTRYPOINT    ["gchgrp"]
