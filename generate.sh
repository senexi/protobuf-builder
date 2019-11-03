#!/bin/bash

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
        --gogoslick_out=plugins=grpc:$OUT_GO \
        --grpc-gateway_out=logtostderr=true:$OUT_GO \
        --swagger_out=logtostderr=true:$OUT_SWAGGER \
        --doc_out=markdown,${basename}.md:$OUT_DOCS \
	--plugin=protoc-gen-grpc-java=/usr/bin/protoc-gen-grpc-java \
	--grpc-java_out=$OUT_JAVA \
	$i
    python3 -m grpc_tools.protoc -I . -I=${GOPATH}/src -I=${GOPATH}/src/github.com/gogo/protobuf/protobuf \
        -I=${GOPATH}/src/github.com/gogo/googleapis/ \
	-I=${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
        -I=$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/ \
	--python_out=$OUT_PYTHON \
	--grpc_python_out=$OUT_PYTHON \
	$i
done

if [ -z "$GIT_REPO" ]
then
      exit 0;
else
      echo "peparing git commit"
fi

eval "$(ssh-agent)"
ssh-add <(echo "$GIT_KEY")

cd /tmp
git clone $GIT_REPO repo
cd repo
cp -R /generated .
git add --all && git commit -am"added generated protobuf artifacts"
git push


