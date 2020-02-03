CWD:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

images:
	docker build -t lambda-layer-mruby ./runtime
layers: images
	docker run --rm -i -v ${CWD}/layers:/tmp lambda-layer-mruby zip -r /tmp/layer-mruby.zip bin/mruby lib bootstrap -x *.rb
publish-layers: layers
	aws lambda publish-layer-version --layer-name layer-mruby --zip-file fileb://./layers/layer-mruby.zip --compatible-runtimes provided
functions: images
	docker run --rm -i -v ${CWD}/functions:/tmp lambda-layer-mruby /tmp/compile.sh
