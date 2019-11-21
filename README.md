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
mkdir -p out
docker run -v $(pwd)/example:/proto -v $(pwd)/out:/generated senexi/protobuf-builder:latest
```

Optinally you can also pass is an ssh key and a git repository to which the generated files should be pushed.

```
docker run --env GIT_KEY="$(cat ./ssh/YOU_SECRET_KEY)" --env GIT_REPO="git@github.com:you_generated_repo.git" -v $(pwd)/example:/proto -v $(pwd)/out:/generated senexi/protobuf-builder:latest
```
