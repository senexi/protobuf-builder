#!/bin/bash

OUT=/generated
OUTPUT_BASE=/generated

cd /proto
for i in *.proto; do
    echo "processing $i"
    basename="${i%.*}"
    OUT=$OUTPUT_BASE/$basename
    OUT_GO=$OUT/language/go
    OUT_JAVA=$OUT/language/java
    OUT_PYTHON=$OUT/language/pyhton
    OUT_DOCS=$OUT/docs
    OUT_SWAGGER=$OUT/swagger
    mkdir -p $OUT_GO $OUT_JAVA $OUT_PYTHON $OUT_DOCS $OUT_SWAGGER
    protoc -I . -I=${GOPATH}/src -I=${GOPATH}/src/github.com/gogo/protobuf/protobuf \
        -I=${GOPATH}/src/github.com/gogo/googleapis/ \
        -I=${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
        -I=$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/ \
        $i \
        --gogoslick_out=plugins=grpc:$OUT_GO \
        --grpc-gateway_out=logtostderr=true:$OUT_GO \
        --swagger_out=logtostderr=true:$OUT_SWAGGER \
        --doc_out=markdown,${basename}.md:$OUT_DOCS \
        --java_out=$OUT_JAVA \
        --python_out=$OUT_PYTHON
done
