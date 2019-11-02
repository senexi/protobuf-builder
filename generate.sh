#!/bin/bash

OUT=/generated
OUTPUT_BASE=/generated

cd /proto
for i in *.proto; do
    echo "processing $i"
    basename="${i%.*}"
    mkdir -p $OUTPUT_BASE/$basename
    mkdir -p $OUTPUT_BASE/$basename/clients/java
    mkdir -p $OUTPUT_BASE/$basename/clients/python
    OUT=$OUTPUT_BASE/$basename
    protoc -I . -I=${GOPATH}/src -I=${GOPATH}/src/github.com/gogo/protobuf/protobuf \
        -I=${GOPATH}/src/github.com/gogo/googleapis/ \
        -I=${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
        -I=$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/ \
        $i \
        --gogoslick_out=plugins=grpc:$OUT \
        --grpc-gateway_out=logtostderr=true:$OUT \
        --swagger_out=logtostderr=true:$OUT \
        --doc_out=markdown,${basename}.md:../docs \
        --java_out=$OUT/clients/java \
        --python_out=$OUT/clients/python
done
