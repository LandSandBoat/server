## Build Troubleshooting

## Building from the commandline

_Make sure you have `CMake` available to use in your `PATH` through some means._

The same steps work on Windows and Linux. Run them from the repo root:

```sh
python3 ./tools/build.py
```

Windows: `py -3 .\tools\build.py`

`build.py` is a thin wrapper. It runs these two commands, and you can run them yourself instead:

```sh
cmake --preset default
cmake --build --preset default
```

The `default` preset builds `RelWithDebInfo` configuration. This is the configuration you want for everyday use.

Use the `debug` preset only when you are chasing a serious problem and need full debug information. A `Debug` build of the map server is many times slower:

```sh
cmake --preset debug
cmake --build --preset debug
```

⚠️ Do not configure with a bare `cmake ..`. That leaves `CMAKE_BUILD_TYPE` empty, and our `CMakeLists.txt` stops with:

```txt
CMake Error: Did not recognise CMAKE_BUILD_TYPE  to print out compiler flags.
```

If you see that error, you did not pass a build type. Use a preset, or set one yourself with `-DCMAKE_BUILD_TYPE=RelWithDebInfo`.

## Troubleshooting

### Paths containing spaces

Previously, the build could fail on paths that contain spaces. While it works _now_, it isn't recommended.

### Drive Letters

It appears as though the build will fail if you try to launch it from a raw drive letter (eg. `D:/`). Instead, use a subfolder: `D:/LSB`.

### External Libraries

On Windows, if you have versions of our external libraries installed on your machine, CMake might try to use them. You'll be able to catch this during configuration when CMake reports:

```
-- MARIADB_LIBRARY: C:\mysql-ver-1.0\lib
-- MARIADB_INCLUDE_DIR: C:\mysql-ver-1.0\include
```

This should be reporting the bundled versions we keep, something like this:

```
-- MARIADB_LIBRARY: C:\dev\lsb\ext\lib\mysql
-- MARIADB_INCLUDE_DIR: C:\dev\lsb\ext\include\mysql
```

If this happens, you can override these paths when you configure CMake:

```sh
cmake --preset default -DMARIADB_INCLUDE_DIR=C:\dev\lsb\ext\include\mysql -DMARIADB_LIBRARY=C:\dev\lsb\ext\lib\libmariadb.lib
```
