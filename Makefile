CWD:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

images:
	docker build -t lambda-layer-mruby ./runtime
layers: images
	docker run --rm -i -v ${CWD}/export:/tmp/export lambda-layer-mruby zip -r /tmp/export/layer-mruby.zip .
