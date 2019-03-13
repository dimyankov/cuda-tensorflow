FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04 as base

RUN \   
        apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
                libopencv-dev \
                libtinyxml2-6 \
                libtinyxml2-dev \
                libgstreamer1.0-0 \
                libgstreamer1.0-dev \
                libeigen3-dev \
                libc-bin \
                python3-dev \
                python3-pip \
                openjdk-8-jdk-headless \
                curl \
                wget \
                python \
                unzip \
                bash-completion \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

RUN mkdir /work
WORKDIR /work

RUN wget https://github.com/bazelbuild/bazel/releases/download/0.18.0/bazel_0.18.0-linux-x86_64.deb \
        && dpkg -i bazel_0.18.0-linux-x86_64.deb \
        && rm bazel_0.18.0-linux-x86_64.deb

RUN wget https://github.com/tensorflow/tensorflow/archive/v1.10.0.tar.gz -O tensorflow_1.10.0.tar.gz \
        && tar zxvf tensorflow_1.10.0.tar.gz \
        && rm tensorflow_1.10.0.tar.gz

ADD .tf_configure.bazelrc /work/tensorflow-1.10.0

RUN cat /work/tensorflow-1.10.0/.tf_configure.bazelrc

RUN cd /work/tensorflow-1.10.0/ && bazel build -c opt //tensorflow:libtensorflow_cc.so
