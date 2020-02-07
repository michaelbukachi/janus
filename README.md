# janus
A docker image for janus webrtc server

### docker-compose.yml example:
```
version: '3.4'

services:
  janus: michaelbukachi/janus:latest
    image: 
    ports: 
      - 8088:8088
      - 8089:8089
```
