# sudo docker build -t darren/opencv-cuda:11.3.1-cudnn8-devel-ubuntu20.04-opencv-4.5.2 app/.
FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04

ARG OPENCV_VERSION=4.5.3
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get upgrade -y
# Install build tools, build dependencies and python
RUN apt-get install -y \
    python3-pip \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    yasm \
    pkg-config \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libavformat-dev \
    libpq-dev \
    libxine2-dev \
    libglew-dev \
    libtiff5-dev \
    zlib1g-dev \
    libjpeg-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libpostproc-dev \
    libswscale-dev \
    libeigen3-dev \
    libtbb-dev \
    libgtk2.0-dev \
    pkg-config \
    ## Python
    python-dev \
    python-numpy \
    python3-dev \
    python3-numpy \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get remove -y cmake

COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

RUN cd /opt/ &&\
    # Download and unzip OpenCV and opencv_contrib and delte zip files
    wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip &&\
    unzip $OPENCV_VERSION.zip &&\
    rm $OPENCV_VERSION.zip &&\
    wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip &&\
    unzip ${OPENCV_VERSION}.zip &&\
    rm ${OPENCV_VERSION}.zip &&\
    # Create build folder and switch to it
    mkdir /opt/opencv-${OPENCV_VERSION}/build && cd /opt/opencv-${OPENCV_VERSION}/build &&\
    # Cmake configure
    cmake \
        -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib-${OPENCV_VERSION}/modules \
        -D WITH_CUDA=ON \
        -D WITH_CUDNN=ON \
        -D OPENCV_DNN_CUDA=ON \
        -D CMAKE_BUILD_TYPE=RELEASE \
        -D OPENCV_ENABLE_NONFREE=ON \
        # Install path will be /usr/local/lib (lib is implicit)
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        # Change the compute capability value to your GPU's value
        # -D CUDA_ARCH_BIN=6.1 \
        .. &&\
    # Make
    make -j"$(nproc)" && \
    # Install to /usr/local/lib
    make install && \
    ldconfig
    # Remove OpenCV sources and build folder
    # rm -rf /opt/opencv-${OPENCV_VERSION} && \
    # rm -rf /opt/opencv_contrib-${OPENCV_VERSION}

WORKDIR /src
