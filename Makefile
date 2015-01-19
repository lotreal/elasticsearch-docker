NAME = es
IMAGE = dockerfile/elasticsearch:latest

# Sample: ELASTICSEARCH_DOCKER_DATA=/luo/var/elasticsearch make run
ELASTICSEARCH_DOCKER_DATA ?= /data/elasticsearch
BSDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
CONFIG = $(BSDIR)/etc/elasticsearch.yml


define docker_run_flags
--volume ${ELASTICSEARCH_DOCKER_DATA}:/data \
--volume ${CONFIG}:/elasticsearch/config/elasticsearch.yml
endef


.PHONY: build
build:
	docker build --tag $(IMAGE) .

.PHONY: pull
pull:
	docker pull $(IMAGE)

.PHONY: push
push:
	docker push $(IMAGE)

.PHONY: test
test:
	docker run --rm -it $(docker_run_flags) $(IMAGE) bash

.PHONY: clean
clean:
	docker rm -f $(NAME)

.PHONY: run
run:
	docker run --detach --name $(NAME) $(docker_run_flags) $(IMAGE)

.PHONY: shell
shell:
	docker exec -it $(NAME) bash

.PHONY: curl
curl:
	curl `docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(NAME)`:9200/_search
