#!/bin/bash

WORKING_DIR=~
cd ${WORKING_DIR}

# Specify OpenCV version
OPENCV_VERSION=4.5.1

echo Downloading OpenCV-${OPENCV_VERSION}
wget -O opencv.zip https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
echo Downloading OpenCV-Contrib-${OPENCV_VERSION}
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip

echo Extracting downloaded files...
unzip opencv.zip
unzip opencv_contrib.zip

# Rename folder name to exclude version postfix
mv opencv-${OPENCV_VERSION} opencv
mv opencv_contrib-${OPENCV_VERSION} opencv_contrib
