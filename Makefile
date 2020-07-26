ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
VERSION=$(shell cat $(ROOT_DIR)/VERSION)
REMOTE=docker.pkg.github.com/fburato/murmur/murmur

build: 
	docker build -t murmur:$(VERSION) $(ROOT_DIR)

publish: build
	docker tag murmur:$(VERSION) $(REMOTE):$(VERSION)
	docker push $(REMOTE):$(VERSION)
