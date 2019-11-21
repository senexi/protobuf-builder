# protobuf-builder

Docker image that contains all the neccessary dependencies to create various GRPC artifacts 
from protobuf definitions.

Supported languages:
- go
- java
- python
- javascript (web)
 
## usage

Run the docker image and mount the input directory containing the protobufs to `/proto` and the 
output directory to `/generated` 

The input directory for the protobuf files can also be modiefied by setting the `PROTO_INPUT` environment variable.

This repo contains a sample protobuf file for try out.

```
git clone https://github.com/senexi/protobuf-builder.git 
docker run -v $(pwd)/example:/src senexi/protobuf-builder:latest
```

Optinally if your mounted path points to a git repo, you can also pass is an ssh key so that the changes are being pushed.

```
docker run --env GIT_KEY="$(cat ./ssh/YOU_SECRET_KEY)" -v $(pwd)/example:/src senexi/protobuf-builder:latest
```
