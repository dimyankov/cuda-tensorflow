DOCKER_TAG=cuda_caps_`grep TF_CUDA_COMPUTE_CAPABILITIES .tf_configure.bazelrc | cut -d '=' -f 2 | tr -d '"'`

build:
	docker build -t cuda-10-tensorflow-1.10:$(DOCKER_TAG) .
        
extract-libraries:
	mkdir -p shared-$(DOCKER_TAG) \
	&& docker run --rm -v `pwd`/shared-$(DOCKER_TAG):/shared cuda-10-tensorflow-1.10:$(DOCKER_TAG) \
			bash -c 'cp /work/tensorflow-1.10.0/bazel-bin/tensorflow/libtensorflow_cc.so /shared && \
					 cp /work/tensorflow-1.10.0/bazel-bin/tensorflow/libtensorflow_framework.so /shared'
