build:
	docker build -t cuda-10-tensorflow-1.10:cuda_caps_`grep TF_CUDA_COMPUTE_CAPABILITIES .tf_configure.bazelrc | cut -d '=' -f 2 | tr -d '"'` .
        
extract-libraries:
	mkdir -p shared \
	&& docker run --rm -v `pwd`/shared:/shared cuda-10-tensorflow-1.10:`grep TF_CUDA_COMPUTE_CAPABILITIES .tf_configure.bazelrc | cut -d '=' -f 2 | tr -d '"'` \
			bash -c 'cp /work/tensorflow-1.10.0/bazel-bin/tensorflow/libtensorflow_cc.so /shared && \
					 cp /work/tensorflow-1.10.0/bazel-bin/tensorflow/libtensorflow_framework.so /shared'
