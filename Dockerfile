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
    openssh-client 

RUN apk add grpc-java --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

ENV PYTHONUNBUFFERED=1

RUN python3 -m pip install --upgrade pip && python3 -m pip install grpcio && python3 -m pip install grpcio-tools

RUN go get -u -v github.com/golang/protobuf/protoc-gen-go && \
    go get -u -v github.com/gogo/protobuf/protoc-gen-gofast && \
    go get -u -v github.com/gogo/protobuf/proto && \
    go get -u -v github.com/gogo/protobuf/protoc-gen-gogoslick && \
    go get -u -v github.com/gogo/protobuf/gogoproto && \
    go get -u -v github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc && \
    go get -u -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && \
    go get -u -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger && \
    go get -u -v github.com/gogo/googleapis/...

RUN wget -O protoc-gen-grpc-web https://github.com/grpc/grpc-web/releases/download/1.0.7/protoc-gen-grpc-web-1.0.7-linux-x86_64 && chmod +x protoc-gen-grpc-web && mv protoc-gen-grpc-web /usr/local/bin

RUN mkdir /entrypoint /generated /proto
COPY generate.sh /entrypoint
WORKDIR /entrypoint
RUN chmod +x /entrypoint/generate.sh 
RUN addgroup -g 1000 -S app && \
    adduser -u 1000 -S app -G app
RUN git config --system user.email "protobuf@builder.com" && git config --system user.name "Protobuf Builder"
USER app
ENV GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
ENTRYPOINT ["/bin/bash", "/entrypoint/generate.sh"]
