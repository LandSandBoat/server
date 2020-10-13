IF EXIST CMakeCache.txt (
    del CMakeCache.txt
)
cmake -G "Visual Studio 15 2017" -A x64 ..