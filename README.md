#protobuf-builder

Docker image that contains all the neccessary dependencies to create various GRPC artifacts 
from protobuf definitions.

Supported languages:
- go
- java
- python
 
## usage

Run the docker image and mount the input directory containing the protobufs to `/proto` and the 
output directory to `/generated` 

```
docker run -v example:/proto -v out:/generated senexi/protobuf-builder:latest
```
