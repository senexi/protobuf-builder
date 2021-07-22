ARG ARCH
FROM ${ARCH}/golang:1.16.6

ARG PB_ARCH
ARG PB_REL="https://github.com/protocolbuffers/protobuf/releases"
ARG PB_VER="3.17.3"

RUN wget -P ${PB_REL}/download/v${PB_VER}/protoc-${PB_VER}-${PB_ARCH}.zip /tmp/protoc && \
    chmod +x /tmp/protoc/bin/protoc && \
    mv /tmp/protoc/bin/protoc /usr/bin
RUN go get -u -v github.com/golang/protobuf/protoc-gen-go && \
    go get -u -v github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc && \


RUN addgroup -g 1000 -S app && \
    adduser -u 1000 -S app -G app
RUN git config --system user.email "protobuf@builder.com" && git config --system user.name "Protobuf Builder"
USER app
ENV GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
CMD ["/bin/bash", ""]
