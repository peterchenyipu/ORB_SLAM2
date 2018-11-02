#!/usr/bin/env bash

# Install Pangolin
ORB_SLAM2_PATH=$(pwd)
cd ~
sudo apt-get install libglew-dev cmake -y
git clone https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
mkdir build
cd build
cmake ..
cmake --build .
sudo make install

# Install OpenCV
cd ~
sudo apt-get install build-essential -y
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev  -y
sudo apt-get install libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev libeigen3-dev -y
sudo apt-get install unzip -y
wget https://github.com/opencv/opencv/archive/3.4.3.zip -O opencv-3.4.3.zip
unzip opencv-3.4.3.zip
cd opencv-3.4.3
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local  -DINSTALL_C_EXAMPLES=ON -DINSTALL_PYTHON_EXAMPLES=ON -DWITH_IPP=ON -DBUILD_NEW_PYTHON_SUPPORT=ON -DWITH_TBB=ON -DWITH_V4L=ON -DWITH_QT=ON -DWITH_OPENGL=ON -DWITH_OPENCL=ON -DWITH_VTK=ON -DBUILD_TIFF=ON -DWITH_EIGEN=ON  -DPYTHON_EXECUTABLE=$(which python) -DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") -DPYTHON_PACKAGES_PATH=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")  ..
make -j8
sudo make install

# Compile ORB_SLAM2
cd $ORB_SLAM2_PATH
chmod +x build.sh build_ros.sh run_orb_slam2.sh
./build.sh
./build_ros.sh
echo "export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:${ORB_SLAM2_PATH}/Examples/ROS" >> ~/.bashrc
source ~/.bashrc