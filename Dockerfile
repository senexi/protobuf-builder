FROM golang:1.16.6

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && apt-get -qq install zip \
    make \
    vim

ARG PB_REL=https://github.com/protocolbuffers/protobuf/releases
ARG PB_VER=3.17.3
ARG PB_FILE=protoc-${PB_VER}-linux-x86_64.zip
ARG PB_URL=${PB_REL}/download/v${PB_VER}/${PB_FILE}

ARG PB_DEST=/tmp/protoc
RUN echo ${PB_URL} && wget ${PB_URL} -P ${PB_DEST} && \
    unzip ${PB_DEST}/${PB_FILE} -d ${PB_DEST} && \
    chmod +x ${PB_DEST}/bin/protoc && \
    mv ${PB_DEST}/bin/protoc /usr/local/bin && \
    mv ${PB_DEST}/include /usr/local/bin && \
    chmod -R 755 /usr/local/bin/include

RUN go get -u -v github.com/golang/protobuf/protoc-gen-go && \
    go get -u -v google.golang.org/grpc/cmd/protoc-gen-go-grpc && \
    go get -u -v github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc && \
    mv /go/bin/* /usr/local/bin

RUN adduser dev --disabled-password --gecos ""                          && \
    echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers     && \
    chown -R dev:dev /home/dev /go && \
    chgrp -R 0 /home/dev /go && \
    chmod -R g+rwX /home/dev /go

RUN git config --system user.email "protobuf@builder.com" && \
    git config --system user.name "Protobuf Builder" 
 
USER dev
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV GOBIN /go/bin
ENV PATH="$GOBIN:$PATH"
ENV PATH="$GOROOT/bin:$PATH"
ENV GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
CMD ["/bin/bash"]
