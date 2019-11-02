
FROM golang:alpine

RUN set -ex && apk --update --no-cache add \
    bash \
    make \
    cmake \
    autoconf \
    automake \
    curl \
    tar \
    libtool \
    g++ \
    git \
    openjdk11 \
    libstdc++ \
    ca-certificates \
    nss \
    protobuf \
    wget \
    python3 \
    python3-dev \
    py3-setuptools \
    bash

ENV PYTHONUNBUFFERED=1

RUN python3 -m pip install --upgrade pip && python3 -m pip install grpcio && python3 -m pip install grpcio-tools

RUN wget -O protoc-gen-grpc-java https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.24.1/protoc-gen-grpc-java-1.24.1-linux-x86_32.exe && chmod +x protoc-gen-grpc-java && mv protoc-gen-grpc-java /usr/local/bin

RUN go get -u -v github.com/golang/protobuf/protoc-gen-go && \
    go get -u -v github.com/gogo/protobuf/protoc-gen-gofast && \
    go get -u -v github.com/gogo/protobuf/proto && \
    go get -u -v github.com/gogo/protobuf/protoc-gen-gogoslick && \
    go get -u -v github.com/gogo/protobuf/gogoproto && \
    go get -u -v github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc && \
    go get -u -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && \
    go get -u -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger && \
    go get -u -v github.com/gogo/googleapis/...

RUN mkdir /genrated /entrypoint /proto
COPY generate.sh /entrypoint
WORKDIR /entrypoint
RUN chmod +x /entrypoint/generate.sh
RUN addgroup -g 1000 -S app && \
    adduser -u 1000 -S app -G app
USER app
ENTRYPOINT ["/bin/bash", "/entrypoint/generate.sh"]
