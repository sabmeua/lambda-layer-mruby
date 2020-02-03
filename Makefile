CWD:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

images:
	docker build -t lambda-layer-mruby ./runtime
layers: images
	docker run --rm -i -v ${CWD}/layers:/tmp lambda-layer-mruby zip -r /tmp/layer-mruby.zip bin/mruby lib bootstrap -x *.rb
