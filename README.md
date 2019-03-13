# Introduction
Tensorflow 1.10 build inside a Docker container with CUDA 10.0, based on Ubuntu 18.04 . Used to build `libensorflow_cc.so` and `tensorflow_framework.so`. Can be adapted to build the PIP package - just change the bazel target

## How to use

### Find out which CUDA Capabilities you need
To find out which capabilities are for you check [Wikipedia's CUDA article](https://en.wikipedia.org/wiki/CUDA). Then edit `.tf_configure.bazelrc` and set `TF_CUDA_COMPUTE_CAPABILITIES` to whatever suits you. 

### Building
Tensorflow is built with Bazel 0.18. Just run `make build`. This will build a container with the tag `cuda-10-tensorflow-1.10:cuda-caps-X.Y`.

### Extracting the libraries
To get the compiled libraries, just run `make extract-libraries`. libtensorflow_cc.so and libtensorflow_framework.so will be copied into newly created directory called `shared-cuda-caps-X.Y`
