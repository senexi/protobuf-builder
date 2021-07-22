# protobuf-builder

Docker Image including all dependencies to build a `golang` application with 
GRPC APIs based on protobuf definitions.

alias gopbbuilder='podman run -it --rm -w /go/src -v $(pwd):/go/src  -v ~/.ssh:/home/dev/.ssh --userns=keep-id --rm --net=host  protobuf-builder:latest /bin/bash'

```
docker run --env GIT_KEY="$(cat ./ssh/YOU_SECRET_KEY)" -v $(pwd)/example:/src senexi/protobuf-builder:latest
```
