# protobuf-builder

Docker image that contains all the neccessary dependencies to create various GRPC artifacts 
from protobuf definitions.

Supported languages:
- go
- java
- python
 
## usage

Run the docker image and mount the input directory containing the protobufs to `/proto` and the 
output directory to `/generated` 

This repo contains a sample protobuf file for try out.

```
git clone https://github.com/senexi/protobuf-builder.git 
mkdir -p out
docker run -v $(pwd)/example:/proto -v $(pwd)/out:/generated senexi/protobuf-builder:latest
```
