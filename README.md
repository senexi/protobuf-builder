# protobuf-builder


alias gobuilder='podman run -it --rm -w /data -v $(pwd):/data -v ~/.ssh:/home/dev/.ssh --userns=keep-id --rm --net=host  protobuf-builder:latest /bin/bash'

```
docker run --env GIT_KEY="$(cat ./ssh/YOU_SECRET_KEY)" -v $(pwd)/example:/src senexi/protobuf-builder:latest
```
