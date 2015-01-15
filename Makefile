NAME = es
IMAGE = dockerfile/elasticsearch:latest

# Sample: DATA=/luo/var/elasticsearch make run
DATA ?= /data/elasticsearch
BSDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
CONFIG = $(BSDIR)/elasticsearch.yml
PORT = 52100


define docker_run_flags
--publish ${PORT}:9200 \
--volume ${DATA}:/data \
--volume ${CONFIG}:/elasticsearch/config/elasticsearch.yml
endef


.PHONY: test
test:
	docker run --rm -it $(docker_run_flags) $(IMAGE) bash

.PHONY: run
run:
	docker run --detach --name $(NAME) $(docker_run_flags) $(IMAGE)

.PHONY: shell
shell:
	docker exec -it $(NAME) bash
