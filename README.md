# yggdrasil

deployment repo for uswitch/yggdrasil https://github.com/uswitch/yggdrasil

## Files & Folders

- ```docker-compose.yml``` docker-compose for envoy proxy and yggdrasil controller
- ```./config``` config folder for envoy & yggdrasil
- ```./config/config.yaml``` yggdrasil config file (needs to bee added manually!)
- ```./config/certs``` kubernetes ca files
- ```.env``` Environment for docker-compose

# Quick Start

```bash
$ touch config/config.yaml
$ docker-compose up -d
$ ./bin/register_node.sh <cluster-name> <apiServer> <token> <ca cert in base64 encoded>
```