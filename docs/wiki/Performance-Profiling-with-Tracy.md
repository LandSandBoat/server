# Tracy

[https://github.com/wolfpld/tracy](https://github.com/wolfpld/tracy)

> A real time, nanosecond resolution, remote telemetry, hybrid frame and sampling profiler for games and other applications.

![image](https://user-images.githubusercontent.com/1389729/97106613-832f0100-16cb-11eb-8452-267e406bceb9.png)

## Intro

We can't know how good/bad our performance is until we measure it.

`Tracy` is made up of two parts:

- The client - which you build into your program and will broadcast your performance information to the server.
- The server - an external program (available in the Tracy release, now called `tracy-profiler.exe` or `tracy-capture.exe`) which will receive the information and allow you to analyze it.

## Setup

### Command Line

If building on the command line:

- Add `-DTRACY_ENABLE=ON` to your configuration arguments and build as normal.

Useful example commandline setup:

```sh
cmake -S . -B build -G Ninja -DTRACY_ENABLE=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build --config RelWithDebInfo -j32
```

### Visual Studio

If building from Visual Studio, select one of the `*-Tracy` build configurations and build as normal. To get a fair measure of runtime performance, you probably want to profile the `RelWithDebInfo` variant of the program.

<img width="395" alt="image" src="https://github.com/user-attachments/assets/aab0f2f8-b693-4112-9523-17005a6f20e8">

```sh
1> Working directory: C:\ffxi\server\build\x64-Release-Tracy
1> [CMake] -- C:/ProgramData/chocolatey/bin/ccache.exe found and enabled
1> [CMake] -- CMAKE_SOURCE_DIR: C:/ffxi/server
1> [CMake] -- CMAKE_SIZEOF_VOID_P == 8: 64-bit build
1> [CMake] -- ENABLE_FAST_MATH: ON
1> [CMake] -- TRACY_ENABLE: ON
1> [CMake] -- Downloading Tracy development library
1> [CMake] x tracy-0.8.2/
1> [CMake] x tracy-0.8.2/.github/
1> [CMake] x tracy-0.8.2/.github/FUNDING.yml
1> [CMake] x tracy-0.8.2/.github/sponsor.png
1> [CMake] x tracy-0.8.2/.github/workflows/
... 
1> [CMake] -- Downloading Tracy client
1> [CMake] x tracy-profiler.exe
...
1> [CMake] -- Modifying C:/ffxi/server/ext/tracy/tracy-0.8.2/client/TracyProfiler.hpp
...
1> [CMake] -- Configuring done
1> [CMake] -- Generating done
1> [CMake] -- Build files have been written to: C:/ffxi/server/build/x64-Release-Tracy
```

## Usage (Windows)

During the Tracy-enabled build from the previous steps, the client code will be downloaded and built into `xi_map` build target. The server executables will also be downloaded and placed in the repo root (`tracy-profiler.exe`, etc.).

The build will output `xi_map_tracy.exe` instead of `xi_map.exe`, so you can continue to run multi-process setups by swapping out the single `xi_map.exe` process you want to profile with the Tracy-enabled `xi_map_tracy.exe`.

**WARNING:** Tracy is designed to only bind to and profile a single executable at a time. If you launch multiple `xi_map_tracy.exe`'s at the same time, you will need to set environment variables before each exe launches so Tracy can serve on different ports. On Linux this looks like: `TRACY_PORT=8088 ./xi_map_tracy --other-args etc. --stuff 1`

**WARNING:** On Windows, Tracy can only properly gather all the information it needs if you run `xi_map_tracy.exe` as **Administrator/root**. There are loud warnings if you don't do this, so you're unlikely to miss them.

Run your `xi_map_tracy.exe` as Administrator/root and then launch `tracy-profiler.exe`.

![image](https://github.com/LandSandBoat/server/assets/1389729/89b7bffe-a170-4398-b08c-d04e8c392fa3)

You can connect to your local machine (`127.0.0.1`) or you can enter the IP address of another machine on your network to connect to it. You'll need to make sure port `8086` is open.

Press `Connect`.

You will see it connect and start profiling.

You can launch `tracy-profiler.exe` before or after `xi_map.exe`, it isn't important.

It is usually better to wait until startup has completed before you attach Tracy, as the startup routine isn't a good indicator of the server's runtime performance. The startup is also incredibly intensive in terms of how much data is collected and transmitted. If you don't need to profile the startup specifically, you should only attach `tracy-profiler.exe` once the server is up and running.

Once connected, you should see something like this:

![image](https://user-images.githubusercontent.com/1389729/184949465-373513d3-5af2-4737-8734-3bf12e14a24f.png)

If you want to record a trace for later use you can click on the `Wifi symbol` and you'll be given the option to save the current trace.

![image](https://user-images.githubusercontent.com/1389729/184949741-25c5c6a9-fa5e-4beb-80b2-3d0202058aa2.png)

**WARNING** Traces can be very large! Plan accordingly!

## Usage (Linux/Mac/Headless)

If you need to capture a trace without launching the GUI (ie. on Linux/Mac where the full GUI isn't easily buildable, on a remote VM, a resource constrained system, etc.), Tracy comes with `tracy-capture.exe`. We automatically build it for you on Linux/Mac builds.

We provide a capture helper script which you can launch as: `python3 ./tools/capture.py (--port 8088 etc. if needed)`. By default this will capture for 60 seconds, then close. This is normally sufficient.

You can open the resulting Trace in the `tracy-profiler.exe` GUI at a later time, or decompose it into a CSV with `tracy-csvextract.exe`.

## Finding Problems

Searchable statistics are in the `Statistics` header, log messages are in `Messages`. You can click and drag and zoom around the main timeline window for information about whats going on. You can "re-attach" to the most active frames by clicking on the `Pause/Resume` header and using the options there.

![image](https://user-images.githubusercontent.com/1389729/184949889-ac577f3b-8124-42e2-8954-493289a86683.png)

![image](https://user-images.githubusercontent.com/1389729/184949998-5cade8da-af6c-49a5-8115-e37f2014655d.png)

If you click on the entries in the `Statistics` menu, you can drill down into that function and look at it in more detail.

![image](https://user-images.githubusercontent.com/1389729/184950126-3e32ad0c-3f30-48ac-945d-6a6efd120633.png)

## Gotchas

Remember that there are a lot of things that can affect performance.

- Platform (Windows, Linux, OSX)
- Architecture (x86, x86_64)
- Type of build (Debug, RelWithDebugInfo, Release, MinSizeRel)
- Compiler (MSVC, Clang, GCC)
- Your system specs (CPU Speed, Available Memory, Memory Latency, HDD R/W speed etc.)
- Other programs using your system's resources
- Virtualization/Containerization (VMWare, WSL, Docker)

If you're performing before/after testing, try as hard as you can to make sure the conditions are the same for both runs and change as little as possible for each change. It is also helpful to take multiple readings and many samples per reading to try and get an accurate view of performance.

It's also possible to convince yourself that something is very expensive by looking at the distribution of time spent in child calls for a given function. If a function is only taking `nanoseconds` overall, but it's spending 80% of its time in a particular child call, this probably isn't a good candidate for investigation.

## Known bottlenecks

- Expensive pathing and navmesh access... all the time... every tick... every mob... everywhere...
- `parse` routine is slow.
- Next to nothing is threaded, almost everything is blocking.
