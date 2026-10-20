# How to build the bundled LuaJIT (it has no CMake support):
#
# Clone https://github.com/LuaJIT/LuaJIT, current commit 1d7b5029c5ba36870d25c67524034d452b761d27.
# From <LuaJIT root>/src in a VS x64 developer prompt, run msvcbuild, then:
#   python tools/rename_dll.py lua51.dll libluajit_64.dll x64
# Put the .lib in ext/luajit/lib64 and the .dll in the repo root.
#
# TEST AND MAKE SURE THAT EVERYTHING STILL WORKS!

xi_find_bundled_library(LuaJIT LuaJIT luajit
    NAMES luajit luajit_64 luajit-5.1 libluajit libluajit_64
    LIBRARY_DIR luajit
    INCLUDE_DIR ext/luajit/include
)
