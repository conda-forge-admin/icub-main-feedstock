#!/bin/sh

cd ${SRC_DIR}/bindings

rm -rf build
mkdir build
cd build

# Workaround for SP_DIR value that somestimes as of October 2024 seems wrong
Python_SP_DIR="$(python -c 'import sysconfig; print(sysconfig.get_path("purelib"))')"
cmake ${CMAKE_ARGS} -GNinja .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DPython_EXECUTABLE:PATH=$PYTHON \
    -DCREATE_PYTHON:BOOL=ON \
    -DCREATE_RUBY:BOOL=OFF \
    -DCREATE_JAVA:BOOL=OFF \
    -DCREATE_CSHARP:BOOL=OFF \
    -DCMAKE_INSTALL_PYTHONDIR:PATH=${Python_SP_DIR}

ninja -v
cmake --build . --config Release --target install
