# Elasticsearch-Docker

Run elasticsearch with docker.

## Quick Start

```
git clone https://github.com/lotreal/elasticsearch-docker.git
cd elasticsearch-docker
make pull run
```

## Settings

### ELASTICSEARCH_DOCKER_DATA

The default dir of elasticsearch's data is: /data/elasticsearch. And you can change it before run:

```
export ELASTICSEARCH_DOCKER_DATA=/luo/var/elasticsearch
```

### elasticsearch.yml

```
vi etc/elasticsearch.yml
```
