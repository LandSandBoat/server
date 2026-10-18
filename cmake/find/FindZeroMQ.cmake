# How to build the bundled ZeroMQ:
#
# git clone --branch v4.3.4 --depth 1 https://github.com/zeromq/libzmq.git
# cmake -DCMAKE_BUILD_TYPE=Release -A x64 -S libzmq -B libzmq/build64 -DBUILD_TESTS=NO -DZMQ_BUILD_TESTS=NO -DENABLE_CURVE=NO -DWITH_TLS=NO
# cmake --build libzmq/build64 --config Debug
# cmake --build libzmq/build64 --config Release
#
# Libs and dlls land in libzmq/build64/{lib,bin}/<config>. Rename them from a VS x64 developer prompt:
#   python tools/rename_dll.py libzmq-v143-mt-4_3_4.dll libzmq_64.dll x64
#   python tools/rename_dll.py libzmq-v143-mt-gd-4_3_4.dll libzmq-d_64.dll x64
#
# When updating the libs, also update cppzmq (zmq.hpp and zmq_addon.hpp): https://github.com/zeromq/cppzmq
#
# TEST AND MAKE SURE THAT EVERYTHING STILL WORKS!

xi_find_bundled_library(ZeroMQ ZeroMQ zeromq
    NAMES zmq zmq_64 libzmq libzmq_64
    LIBRARY_DIR zmq
    INCLUDE_DIR ext/zmq/include/zmq
)
