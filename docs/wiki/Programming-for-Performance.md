# Programming for Performance

## Threading (Multi vs Single Threading)

LSB and its predecessors are mostly single-threaded. This means we have to be conscious of how much work we're doing at any given time. If we commit to doing too much work, or the work takes too long, the performance of the server will degrade; leading to lag and/or instability.

Below are some very basic benchmarks comparing similar workloads in C++, in Lua using function caching, and Lua without using funciton caching.

```txt
--------------------------------------------------------------------
Benchmark                          Time             CPU   Iterations
--------------------------------------------------------------------
BM_Core_Function                2.13 ns         2.13 ns    448000000
BM_Sol_Cache_Function           56.4 ns         55.8 ns      8960000
BM_Lua_Read_From_Disk          61804 ns        61384 ns        11200
```

As you can see, C++ is the clear winner, with function-cached Lua being an order of magnitude slower, and with uncached Lua being a further order of magnitude slower than that.

This means that if a piece of work is particularly large or performance critical it should be moved into C++. Otherwise, it's probably fine to exist in Lua.

**NOTE:** This comparison doesn't include SQL queries. They tend to be as slow, or slower than disk reads. Read and write from SQL as little as possible (or cache everything you can!).

### Performance critical systems that should always stay in C++:

- Networking (packet sending/recieving with the client)
- Communication between processes (IPC & RPC)
- Entity iteration
- Navmesh access
- LoS mesh access
- Path finding
- Target finding
- Target validation
- AI of regular Mobs, NPCs, Pets, and Trusts
- Database reads & writes
- File reads & writes

There are obvious caveats to all of this. If you can offload this work to a worker thread and pick up the results later, or action the results on a later tick: great! Do that! But be aware of the foot-guns associated with multi-threaded code. The main foible this codebase has is that the Lua state is **NOT THREAD SAFE EVEN SLIGHTLY, DON'T EVEN TRY! Anything that touches the Lua state needs to be on the main thread.**
