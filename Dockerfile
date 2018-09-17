FROM alpine:3.8
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/community" >> /etc/apk/repositories
RUN apk update -U
RUN apk add emscripten-fastcomp make python2 cmake musl-dev git gcc
RUN git clone https://github.com/juj/emsdk.git /usr/src/emsdk
RUN cd /usr/src/emsdk && \
    ./emsdk install #--build=Release sdk-incoming-64bit binaryen-master-64bit
RUN cd /usr/src/emsdk && \
    ./emsdk activate #--build=Release sdk-incoming-64bit binaryen-master-64bit
RUN cd /usr/src/emsdk && \
    source ./emsdk_env.sh #--build=Release
RUN git clone https://github.com/eyedeekay/xmr-wasm.git /usr/src/xmr-wasm
WORKDIR /usr/src/xmr-wasm
RUN make
CMD make run
