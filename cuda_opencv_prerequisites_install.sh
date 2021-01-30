#!/bin/bash

# updates local repository cache
sudo apt update
# updates all the packages
sudo apt upgrade

# Generic packages
sudo apt install build-essential git cmake pkg-config unzip yasm checkinstall
# Image libraries
sudo apt install libjpeg-dev libpng-dev libtiff-dev
# Audio/Video Libs
sudo apt install libavcodec-dev libavformat-dev libswscale-dev libavresample-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libxvidcore-dev x264 libx264-dev libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev python3-dev libatlas-base-dev gfortran libgtk-3-dev libv4l-dev
# OpenCV Optimization libraries
sudo apt-get install libatlas-base-dev gfortran
# Python3 libraries
sudo apt-get install python3-dev python3-pip python3-testresources
pip3 install -U pip numpy

# Speech codecs [Optional Packages: Uncomment below line to execute/install]
#sudo apt install libopencore-amrnb-dev libopencore-amrwb-dev
# Camera libs [Optional Packages: Uncomment below 4 lines to execute/install]
#sudo apt-get install libdc1394-22 libdc1394-22-dev libxine2-dev libv4l-dev v4l-utils
#cd /usr/include/linux
#sudo ln -s -f ../libv4l1-videodev.h videodev.h

# Optional Packages: Uncomment below 4 lines to execute/install
#sudo apt-get install libprotobuf-dev protobuf-compiler libgoogle-glog-dev libgflags-dev libgphoto2-dev libeigen3-dev libhdf5-dev doxygen
