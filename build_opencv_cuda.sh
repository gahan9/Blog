#!/bin/bash

# Run the prerequisites first... from file: download_and_build_opencv.sh
export WORKING_DIR=${PWD}
cd "${WORKING_DIR}"/opencv || exit

# make build directory and switch to it
mkdir build
cd build || exit

# Similar to CUDA_ARCH_BIN=8.6 just dynamically find out CUDA compute capability
OUTPUT=$(nvcc --list-gpu-arch | tail -1)
CUDA_ARCH_BIN=${OUTPUT: -2:-1}.${OUTPUT: -1}
echo CUDA Compute Capability is "${CUDA_ARCH_BIN}"

# Setup the below variable/paths as per your environment
PYTHON_EXECUTABLE=~/.virtualenvs/env1/bin/python3
OPENCV_PYTHON3_INSTALL_PATH=~/.virtualenvs/env1/lib/python3.8/site-packages
OPENCV_EXTRA_MODULES_PATH=${WORKING_DIR}/opencv_contrib/modules

cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_C_COMPILER=/usr/bin/gcc-6 \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D WITH_TBB=ON \
-D WITH_CUDA=ON \
-D BUILD_opencv_cudacodec=OFF \
-D BUILD_SHARED_LIBS=OFF \
-D ENABLE_FAST_MATH=1 \
-D CUDA_FAST_MATH=1 \
-D WITH_CUBLAS=1 \
-D WITH_V4L=ON \
-D WITH_QT=OFF \
-D WITH_OPENGL=ON \
-D WITH_GSTREAMER=ON \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D OPENCV_PC_FILE_NAME=opencv.pc \
-D OPENCV_ENABLE_NONFREE=ON \
-D WITH_CUDNN=ON \
-D OPENCV_DNN_CUDA=ON \
-D CUDA_nppicom_LIBRARY=true\
-D HAVE_opencv_python3=ON \
-D ENABLE_PRECOMPILED_HEADERS=OFF \
-D OPENCV_PYTHON3_INSTALL_PATH=${OPENCV_PYTHON3_INSTALL_PATH} \
-D OPENCV_EXTRA_MODULES_PATH="${OPENCV_EXTRA_MODULES_PATH}" \
-D PYTHON_EXECUTABLE=${PYTHON_EXECUTABLE} \
-D CUDA_ARCH_BIN="${CUDA_ARCH_BIN}" \
-D BUILD_TIFF=ON \
-D BUILD_EXAMPLES=ON ..

# Go to build directory
cd "${WORKING_DIR}"/opencv/build

# Run the job (configured from cmake)
# if you have more than 4 cpu cores you can take as many jobs to make flag to accelerate the process
# i.e. make -j12 if you have 12 CPU cores
make -j4

# Install the library component
make install
sudo ldconfig

# Link with System Interpreter
PY_VERSION=$(python3 --version)
PY3_VERSION=${PY_VERSION: -5:-2}
sudo cp -r cd ${OPENCV_PYTHON3_INSTALL_PATH}/cv2 /usr/local/lib/python"${PY3_VERSION}"/dist-packages
#sudo nano /usr/local/lib/python"${PY3_VERSION}"/dist-packages/cv2/config-"${PY3_VERSION}".py
#MAJOR_PY_VERSION=${PY_VERSION: -5:-4}
#MINOR_PY_VERSION=${PY_VERSION: -3:-2}
#ln -s /usr/local/lib/python${MAJOR_PY_VERSION}.${MINOR_PY_VERSION}/dist-packages/cv2/python-${MAJOR_PY_VERSION}.${MINOR_PY_VERSION}/cv2.cpython-"${MAJOR_PY_VERSION}""${MINOR_PY_VERSION}"m-x86_64-linux-gnu.so cv2.so
