# Troubleshooting with Sanitizers

LSB supports several sanitizer build types via CMake, defined in `cmake/Sanitizers.cmake`.

These are supported first-class in GCC/Clang on Linux, and to a lesser degree on MSVC/Windows.

Please refer to Microsoft documentation [on their website](https://learn.microsoft.com/en-us/cpp/sanitizers/asan?view=msvc-170) to learn about using sanitizers on Windows as information in this article **do not necessarily apply**.

## Why use sanitizers

Some bugs slip through code review and static analysis (use-after-free, buffer overflows, undefined behavior) and cause crashes or corruption that are hard to reproduce and harder to diagnose. 

Sanitizers catch these at runtime with detailed stack traces, turning what could be weeks of investigation into a quick fix.

## Available Build Types

| Build Type | What It Detects                                                                               |
|------------|-----------------------------------------------------------------------------------------------|
| `ASAN`     | Heap/stack/global buffer overflow, use-after-free, use-after-scope, double-free, memory leaks |
| `UBSAN`    | Signed integer overflow, null pointer dereference, bad casts, misaligned access, shift UB     |

## Warnings
You should be aware that running sanitizers comes with certain downsides:
- Performance will be impacted by 2 to 5x depending on the sanitizer used
- Sanitizers inject custom instrumentation into the code that may present security issues of their own and/or have bad interactions with LSB code.
- Failing to disable `halt_on_error` will cause sanitizers to abort on severe issues.

## Building

Pass the sanitizer name as `CMAKE_BUILD_TYPE`:

```bash
# AddressSanitizer
cmake -B build-asan -DCMAKE_BUILD_TYPE=ASAN .
cmake --build build-asan

# UndefinedBehaviorSanitizer
cmake -B build-ubsan -DCMAKE_BUILD_TYPE=UBSAN .
cmake --build build-ubsan
```

To build only `xi_test` for faster iteration:

```bash
cmake --build build-asan --target xi_test
```

Output binaries are placed in the repo root, same as all other build types.

## Running

Run any target normally. The sanitizer runtime is linked into the binary and prints reports to stderr when issues are detected.

Depending on the severity of the issue, ASan may elect to abort the process. 
See `halt_on_error` documentation below.

If the process exits naturally, a report about memory leaks will be printed.

### use-after-free example

```bash
./xi_map

[...]

==3087730==ERROR: AddressSanitizer: heap-use-after-free on address 0x5030000a5430 at pc 0x5ce4762ca37f bp 0x7ffd1205b090 sp 0x7ffd1205a858
READ of size 4 at 0x5030000a5430 thread T0
    #0 0x5ce4762ca37e in strlen (/home/sruon/Work/server/xi_map+0x68b37e) (BuildId: a18239e20a361340030a59d354ba91401f848ecd)
    #1 0x7ab3206e4586 in lua_setfield /build/luajit-OdWcyZ/luajit-2.1.0+git20231223.c525bcb+dfsg/src/lj_api.c:992:20
    #2 0x5ce476fc12b6 in void sol::stack::field_setter<char const*, false, false, void>::set<char const*, sol::lua_nil_t const&>(lua_State*, char const*&&, sol::lua_nil_t const&, int) /home/sruon/Work/server/ext/sol/include/sol/sol.hpp:16259:7
    #3 0x5ce476fc12b6 in void sol::stack::set_field<false, false, char const*, sol::lua_nil_t const&>(lua_State*, char const*&&, sol::lua_nil_t const&, int) /home/sruon/Work/server/ext/sol/include/sol/sol.hpp:12132:59
    #4 0x5ce476fc12b6 in void sol::u_detail::clear_usertype_registry_names<CLuaItem>(lua_State*) /home/sruon/Work/server/ext/sol/include/sol/sol.hpp:24212:3
    #5 0x5ce476fc16ed in int sol::u_detail::destroy_usertype_storage<CLuaItem>(lua_State*) /home/sruon/Work/server/ext/sol/include/sol/sol.hpp:24221:3
    #6 0x7ab3206c53e5 in lj_BC_FUNCC /usr/src/luajit-2.1.0+git20231223.c525bcb+dfsg-1/src/buildvm_x86.dasc:857
    #7 0x7ab3206d36f8 in gc_call_finalizer /build/luajit-OdWcyZ/luajit-2.1.0+git20231223.c525bcb+dfsg/src/lj_gc.c:521:13
    #8 0x7ab3206d453f in lj_gc_finalize_udata /build/luajit-OdWcyZ/luajit-2.1.0+git20231223.c525bcb+dfsg/src/lj_gc.c:580:5
    #9 0x7ab3206d453f in cpfinalize /build/luajit-OdWcyZ/luajit-2.1.0+git20231223.c525bcb+dfsg/src/lj_state.c:290:3
    #10 0x7ab3206c57db in lj_vm_cpcall /usr/src/luajit-2.1.0+git20231223.c525bcb+dfsg-1/src/buildvm_x86.dasc:1246
    #11 0x7ab3206d5f20 in lua_close /build/luajit-OdWcyZ/luajit-2.1.0+git20231223.c525bcb+dfsg/src/lj_state.c:316:9
    #12 0x5ce47680a809 in sol::detail::state_deleter::operator()(lua_State*) const /home/sruon/Work/server/ext/sol/include/sol/sol.hpp:6959:5
    #13 0x5ce47680a809 in std::unique_ptr<lua_State, sol::detail::state_deleter>::~unique_ptr() /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/unique_ptr.h:404:4
    #14 0x5ce47680a809 in sol::state::~state() /home/sruon/Work/server/ext/sol/include/sol/sol.hpp:28265:3
    #15 0x7ab31f847a75 in __run_exit_handlers stdlib/exit.c:108:8
    #16 0x7ab31f847bbd in exit stdlib/exit.c:138:3
    #17 0x5ce47676582c in (anonymous namespace)::handleSignal(std::error_code const&, int) /home/sruon/Work/server/src/common/application.cpp:55:13
    #18 0x5ce476776eef in asio::detail::binder2<void (*)(std::error_code const&, int), std::error_code, int>::operator()() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/bind_handler.hpp:180:5
    #19 0x5ce476776eef in void asio::detail::handler_work<void (*)(std::error_code const&, int), asio::any_io_executor, void>::complete<asio::detail::binder2<void (*)(std::error_code const&, int), std::error_code, int>>(asio::detail::binder2<void (*)(std::error_code const&, int), std::error_code, int>&, void (*&)(std::error_code const&, int)) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/handler_work.hpp:469:7
    #20 0x5ce476776eef in asio::detail::signal_handler<void (*)(std::error_code const&, int), asio::any_io_executor>::do_complete(void*, asio::detail::scheduler_operation*, std::error_code const&, unsigned long) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/signal_handler.hpp:75:9
    #21 0x5ce476396424 in asio::detail::scheduler_operation::complete(void*, std::error_code const&, unsigned long) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/scheduler_operation.hpp:39:5
    #22 0x5ce476396424 in asio::detail::scheduler::do_run_one(asio::detail::conditionally_enabled_mutex::scoped_lock&, asio::detail::scheduler_thread_info&, std::error_code const&) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/impl/scheduler.ipp:500:12
    #23 0x5ce476395ba3 in asio::detail::scheduler::run(std::error_code&) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/impl/scheduler.ipp:216:10
    #24 0x5ce476394e13 in asio::io_context::run() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/io_context.ipp:62:24
    #25 0x5ce476391bcc in Scheduler::run() /home/sruon/Work/server/src/common/scheduler.h:245:26
    #26 0x5ce476391bcc in MapApplication::run() /home/sruon/Work/server/src/map/map_application.cpp:119:20
    #27 0x5ce47638e316 in main /home/sruon/Work/server/src/map/main.cpp:28:13
    #28 0x7ab31f82a1c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #29 0x7ab31f82a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #30 0x5ce4762b2af4 in _start (/home/sruon/Work/server/xi_map+0x673af4) (BuildId: a18239e20a361340030a59d354ba91401f848ecd)

0x5030000a5430 is located 0 bytes inside of 19-byte region [0x5030000a5430,0x5030000a5443)
freed by thread T0 here:
    #0 0x5ce47638c7e1 in operator delete(void*) (/home/sruon/Work/server/xi_map+0x74d7e1) (BuildId: a18239e20a361340030a59d354ba91401f848ecd)
    #1 0x5ce4765fc3a7 in std::__new_allocator<char>::deallocate(char*, unsigned long) /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/new_allocator.h:172:2
    #2 0x5ce4765fc3a7 in std::allocator<char>::deallocate(char*, unsigned long) /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/allocator.h:210:25
    #3 0x5ce4765fc3a7 in std::allocator_traits<std::allocator<char>>::deallocate(std::allocator<char>&, char*, unsigned long) /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/alloc_traits.h:517:13
    #4 0x5ce4765fc3a7 in std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>::_M_destroy(unsigned long) /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/basic_string.h:289:9
    #5 0x5ce4765fc3a7 in std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>::_M_dispose() /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/basic_string.h:283:4
    #6 0x5ce4765fc3a7 in std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>::~basic_string() /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/basic_string.h:804:9
    #7 0x7ab31f847a75 in __run_exit_handlers stdlib/exit.c:108:8
    #8 0x7ab31f847bbd in exit stdlib/exit.c:138:3
    #9 0x5ce47676582c in (anonymous namespace)::handleSignal(std::error_code const&, int) /home/sruon/Work/server/src/common/application.cpp:55:13
    #10 0x5ce476776eef in asio::detail::binder2<void (*)(std::error_code const&, int), std::error_code, int>::operator()() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/bind_handler.hpp:180:5
    #11 0x5ce476776eef in void asio::detail::handler_work<void (*)(std::error_code const&, int), asio::any_io_executor, void>::complete<asio::detail::binder2<void (*)(std::error_code const&, int), std::error_code, int>>(asio::detail::binder2<void (*)(std::error_code const&, int), std::error_code, int>&, void (*&)(std::error_code const&, int)) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/handler_work.hpp:469:7
    #12 0x5ce476776eef in asio::detail::signal_handler<void (*)(std::error_code const&, int), asio::any_io_executor>::do_complete(void*, asio::detail::scheduler_operation*, std::error_code const&, unsigned long) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/signal_handler.hpp:75:9
    #13 0x5ce476396424 in asio::detail::scheduler_operation::complete(void*, std::error_code const&, unsigned long) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/scheduler_operation.hpp:39:5
    #14 0x5ce476396424 in asio::detail::scheduler::do_run_one(asio::detail::conditionally_enabled_mutex::scoped_lock&, asio::detail::scheduler_thread_info&, std::error_code const&) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/impl/scheduler.ipp:500:12
    #15 0x5ce476395ba3 in asio::detail::scheduler::run(std::error_code&) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/impl/scheduler.ipp:216:10
    #16 0x5ce476394e13 in asio::io_context::run() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/io_context.ipp:62:24
    #17 0x5ce476391bcc in Scheduler::run() /home/sruon/Work/server/src/common/scheduler.h:245:26
    #18 0x5ce476391bcc in MapApplication::run() /home/sruon/Work/server/src/map/map_application.cpp:119:20
    #19 0x5ce47638e316 in main /home/sruon/Work/server/src/map/main.cpp:28:13
    #20 0x7ab31f82a1c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #21 0x7ab31f82a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #22 0x5ce4762b2af4 in _start (/home/sruon/Work/server/xi_map+0x673af4) (BuildId: a18239e20a361340030a59d354ba91401f848ecd)

previously allocated by thread T0 here:
    #0 0x5ce47638bf61 in operator new(unsigned long) (/home/sruon/Work/server/xi_map+0x74cf61) (BuildId: a18239e20a361340030a59d354ba91401f848ecd)
    #1 0x5ce476607e5e in std::__new_allocator<char>::allocate(unsigned long, void const*) /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/new_allocator.h:151:27
    #2 0x5ce476607e5e in std::allocator<char>::allocate(unsigned long) /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/allocator.h:198:32
    #3 0x5ce476607e5e in std::allocator_traits<std::allocator<char>>::allocate(std::allocator<char>&, unsigned long) /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/alloc_traits.h:482:20
    #4 0x5ce476607e5e in std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>::_S_allocate(std::allocator<char>&, unsigned long) /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/basic_string.h:126:16
    #5 0x5ce476607e5e in std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>::_M_create(unsigned long&, unsigned long) /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/basic_string.tcc:159:14
    #6 0x5ce476607e5e in void std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>::_M_construct<char*>(char*, char*, std::forward_iterator_tag) /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/basic_string.tcc:229:14
    #7 0x5ce476607e5e in std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>::basic_string(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> const&) /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/basic_string.h:551:2
    #8 0x5ce476fc0eb4 in sol::usertype_traits<CLuaItem const>::metatable[abi:cxx11]() /home/sruon/Work/server/ext/sol/include/sol/sol.hpp:9096:33
    #9 0x5ce476fbff6e in int sol::u_detail::register_usertype<CLuaItem, (sol::automagic_flags)511>(lua_State*, sol::automagic_enrollments) /home/sruon/Work/server/ext/sol/include/sol/sol.hpp:24396:57
    #10 0x5ce476fbfb2f in sol::basic_usertype<CLuaItem, sol::basic_reference<false>> sol::basic_table_core<true, sol::basic_reference<false>>::new_usertype<CLuaItem, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>&, (sol::automagic_flags)511>(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>&, sol::constant_automagic_enrollments<(sol::automagic_flags)511>) /home/sruon/Work/server/ext/sol/include/sol/sol.hpp:26491:18
    #11 0x5ce476fb4def in sol::basic_usertype<CLuaItem, sol::basic_reference<false>> sol::basic_table_core<true, sol::basic_reference<false>>::new_usertype<CLuaItem, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>&>(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>&) /home/sruon/Work/server/ext/sol/include/sol/sol.hpp:26485:16
    #12 0x5ce476fb4def in sol::basic_usertype<CLuaItem, sol::basic_reference<false>> sol::state_view::new_usertype<CLuaItem, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>&>(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>&) /home/sruon/Work/server/ext/sol/include/sol/sol.hpp:27985:18
    #13 0x5ce476fb4def in CLuaItem::Register() /home/sruon/Work/server/src/map/lua/lua_item.cpp:439:5
    #14 0x5ce476ffc5ee in luautils::init(IPP, bool) /home/sruon/Work/server/src/map/lua/luautils.cpp:362:9
    #15 0x5ce4763e8888 in MapEngine::init() (.resume) /home/sruon/Work/server/src/map/map_engine.cpp:149:5
    #16 0x5ce4763c6f61 in std::__n4861::coroutine_handle<void>::resume() const /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/coroutine:135:29
    #17 0x5ce4763c6f61 in asio::detail::awaitable_frame_base<asio::any_io_executor>::resume() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/awaitable.hpp:505:11
    #18 0x5ce4763c6f61 in asio::detail::awaitable_thread<asio::any_io_executor>::pump() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/awaitable.hpp:773:47
    #19 0x5ce4763c6ce3 in asio::detail::awaitable_async_op_handler<void (), asio::any_io_executor, void>::operator()() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/awaitable.hpp:812:11
    #20 0x5ce4763c7b39 in asio::detail::binder0<asio::detail::awaitable_async_op_handler<void (), asio::any_io_executor, void>>::operator()() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/bind_handler.hpp:55:5
    #21 0x5ce4763c7b39 in void asio::detail::executor_function::complete<asio::detail::binder0<asio::detail::awaitable_async_op_handler<void (), asio::any_io_executor, void>>, std::allocator<void>>(asio::detail::executor_function::impl_base*, bool) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/executor_function.hpp:112:7
    #22 0x5ce4763ccda5 in asio::detail::executor_function::operator()() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/executor_function.hpp:60:7
    #23 0x5ce4763ccda5 in asio::detail::executor_op<asio::detail::executor_function, std::allocator<void>, asio::detail::scheduler_operation>::do_complete(void*, asio::detail::scheduler_operation*, std::error_code const&, unsigned long) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/executor_op.hpp:69:7
    #24 0x5ce476396424 in asio::detail::scheduler_operation::complete(void*, std::error_code const&, unsigned long) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/scheduler_operation.hpp:39:5
    #25 0x5ce476396424 in asio::detail::scheduler::do_run_one(asio::detail::conditionally_enabled_mutex::scoped_lock&, asio::detail::scheduler_thread_info&, std::error_code const&) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/impl/scheduler.ipp:500:12
    #26 0x5ce476395ba3 in asio::detail::scheduler::run(std::error_code&) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/impl/scheduler.ipp:216:10
    #27 0x5ce476394e13 in asio::io_context::run() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/io_context.ipp:62:24
    #28 0x5ce476391bcc in Scheduler::run() /home/sruon/Work/server/src/common/scheduler.h:245:26
    #29 0x5ce476391bcc in MapApplication::run() /home/sruon/Work/server/src/map/map_application.cpp:119:20
    #30 0x5ce47638e316 in main /home/sruon/Work/server/src/map/main.cpp:28:13
    #31 0x7ab31f82a1c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #32 0x7ab31f82a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #33 0x5ce4762b2af4 in _start (/home/sruon/Work/server/xi_map+0x673af4) (BuildId: a18239e20a361340030a59d354ba91401f848ecd)

SUMMARY: AddressSanitizer: heap-use-after-free (/home/sruon/Work/server/xi_map+0x68b37e) (BuildId: a18239e20a361340030a59d354ba91401f848ecd) in strlen
Shadow bytes around the buggy address:
  0x5030000a5180: fa fa 00 00 00 fa fa fa 00 00 05 fa fa fa 00 00
  0x5030000a5200: 00 fa fa fa 00 00 00 fa fa fa 00 00 00 fa fa fa
  0x5030000a5280: 00 00 07 fa fa fa fd fd fd fa fa fa fd fd fd fa
  0x5030000a5300: fa fa 00 00 00 fa fa fa 00 00 03 fa fa fa fd fd
  0x5030000a5380: fd fd fa fa 00 00 00 fa fa fa fd fd fd fa fa fa
=>0x5030000a5400: 00 00 00 fa fa fa[fd]fd fd fa fa fa fd fd fd fa
  0x5030000a5480: fa fa fd fd fd fa fa fa 00 00 00 fa fa fa fd fd
  0x5030000a5500: fd fa fa fa 00 00 00 fa fa fa fd fd fd fa fa fa
  0x5030000a5580: 00 00 00 fa fa fa 00 00 00 fa fa fa 00 00 00 fa
  0x5030000a5600: fa fa 00 00 00 fa fa fa fd fd fd fa fa fa 00 00
  0x5030000a5680: 00 fa fa fa 00 00 00 fa fa fa 00 00 00 fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==3087730==ABORTING
```

#### Memory leaks example
```
ASAN_OPTIONS="halt_on_error=0" ./xi_map

[...]

==3096263==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 37696 byte(s) in 38 object(s) allocated from:
    #0 0x62e61366af61 in operator new(unsigned long) (/home/sruon/Work/server/xi_map+0x74cf61) (BuildId: a18239e20a361340030a59d354ba91401f848ecd)
    #1 0x62e614a9ef4b in guildutils::Initialize() /home/sruon/Work/server/src/map/utils/guildutils.cpp:73:39
    #2 0x62e6136c92a2 in MapEngine::init() (.resume) /home/sruon/Work/server/src/map/map_engine.cpp:178:5
    #3 0x62e6136a5f61 in std::__n4861::coroutine_handle<void>::resume() const /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/coroutine:135:29
    #4 0x62e6136a5f61 in asio::detail::awaitable_frame_base<asio::any_io_executor>::resume() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/awaitable.hpp:505:11
    #5 0x62e6136a5f61 in asio::detail::awaitable_thread<asio::any_io_executor>::pump() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/awaitable.hpp:773:47
    #6 0x62e6136a5ce3 in asio::detail::awaitable_async_op_handler<void (), asio::any_io_executor, void>::operator()() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/awaitable.hpp:812:11
    #7 0x62e6136a6b39 in asio::detail::binder0<asio::detail::awaitable_async_op_handler<void (), asio::any_io_executor, void>>::operator()() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/bind_handler.hpp:55:5
    #8 0x62e6136a6b39 in void asio::detail::executor_function::complete<asio::detail::binder0<asio::detail::awaitable_async_op_handler<void (), asio::any_io_executor, void>>, std::allocator<void>>(asio::detail::executor_function::impl_base*, bool) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/executor_function.hpp:112:7
    #9 0x62e6136abda5 in asio::detail::executor_function::operator()() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/executor_function.hpp:60:7
    #10 0x62e6136abda5 in asio::detail::executor_op<asio::detail::executor_function, std::allocator<void>, asio::detail::scheduler_operation>::do_complete(void*, asio::detail::scheduler_operation*, std::error_code const&, unsigned long) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/executor_op.hpp:69:7
    #11 0x62e613675424 in asio::detail::scheduler_operation::complete(void*, std::error_code const&, unsigned long) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/scheduler_operation.hpp:39:5
    #12 0x62e613675424 in asio::detail::scheduler::do_run_one(asio::detail::conditionally_enabled_mutex::scoped_lock&, asio::detail::scheduler_thread_info&, std::error_code const&) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/impl/scheduler.ipp:500:12
    #13 0x62e613674ba3 in asio::detail::scheduler::run(std::error_code&) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/impl/scheduler.ipp:216:10
    #14 0x62e613673e13 in asio::io_context::run() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/io_context.ipp:62:24
    #15 0x62e613670bcc in Scheduler::run() /home/sruon/Work/server/src/common/scheduler.h:245:26
    #16 0x62e613670bcc in MapApplication::run() /home/sruon/Work/server/src/map/map_application.cpp:119:20
    #17 0x62e61366d316 in main /home/sruon/Work/server/src/map/main.cpp:28:13
    #18 0x719b2202a1c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #19 0x719b2202a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #20 0x62e613591af4 in _start (/home/sruon/Work/server/xi_map+0x673af4) (BuildId: a18239e20a361340030a59d354ba91401f848ecd)

Direct leak of 26416 byte(s) in 254 object(s) allocated from:
    #0 0x62e61366af61 in operator new(unsigned long) (/home/sruon/Work/server/xi_map+0x74cf61) (BuildId: a18239e20a361340030a59d354ba91401f848ecd)
    #1 0x62e6147387c5 in battleutils::LoadPetSkillsList() /home/sruon/Work/server/src/map/utils/battleutils.cpp:262:27
    #2 0x62e6136c92cf in MapEngine::init() (.resume) /home/sruon/Work/server/src/map/map_engine.cpp:187:5
    #3 0x62e6136a5f61 in std::__n4861::coroutine_handle<void>::resume() const /usr/bin/../lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/coroutine:135:29
    #4 0x62e6136a5f61 in asio::detail::awaitable_frame_base<asio::any_io_executor>::resume() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/awaitable.hpp:505:11
    #5 0x62e6136a5f61 in asio::detail::awaitable_thread<asio::any_io_executor>::pump() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/awaitable.hpp:773:47
    #6 0x62e6136a5ce3 in asio::detail::awaitable_async_op_handler<void (), asio::any_io_executor, void>::operator()() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/awaitable.hpp:812:11
    #7 0x62e6136a6b39 in asio::detail::binder0<asio::detail::awaitable_async_op_handler<void (), asio::any_io_executor, void>>::operator()() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/bind_handler.hpp:55:5
    #8 0x62e6136a6b39 in void asio::detail::executor_function::complete<asio::detail::binder0<asio::detail::awaitable_async_op_handler<void (), asio::any_io_executor, void>>, std::allocator<void>>(asio::detail::executor_function::impl_base*, bool) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/executor_function.hpp:112:7
    #9 0x62e6136abda5 in asio::detail::executor_function::operator()() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/executor_function.hpp:60:7
    #10 0x62e6136abda5 in asio::detail::executor_op<asio::detail::executor_function, std::allocator<void>, asio::detail::scheduler_operation>::do_complete(void*, asio::detail::scheduler_operation*, std::error_code const&, unsigned long) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/executor_op.hpp:69:7
    #11 0x62e613675424 in asio::detail::scheduler_operation::complete(void*, std::error_code const&, unsigned long) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/scheduler_operation.hpp:39:5
    #12 0x62e613675424 in asio::detail::scheduler::do_run_one(asio::detail::conditionally_enabled_mutex::scoped_lock&, asio::detail::scheduler_thread_info&, std::error_code const&) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/impl/scheduler.ipp:500:12
    #13 0x62e613674ba3 in asio::detail::scheduler::run(std::error_code&) /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/detail/impl/scheduler.ipp:216:10
    #14 0x62e613673e13 in asio::io_context::run() /home/sruon/Work/server/build-asan/_deps/asio-src/asio/include/asio/impl/io_context.ipp:62:24
    #15 0x62e613670bcc in Scheduler::run() /home/sruon/Work/server/src/common/scheduler.h:245:26
    #16 0x62e613670bcc in MapApplication::run() /home/sruon/Work/server/src/map/map_application.cpp:119:20
    #17 0x62e61366d316 in main /home/sruon/Work/server/src/map/main.cpp:28:13
    #18 0x719b2202a1c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #19 0x719b2202a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #20 0x62e613591af4 in _start (/home/sruon/Work/server/xi_map+0x673af4) (BuildId: a18239e20a361340030a59d354ba91401f848ecd)
```

### Environment Variables

Each sanitizer accepts runtime options through environment variables:

```bash
# ASAN: continue after errors, log to files
ASAN_OPTIONS="halt_on_error=0:log_path=asan.log" ./xi_map

# UBSAN: print stack traces on UB
UBSAN_OPTIONS="print_stacktrace=1:halt_on_error=0" ./xi_map
```

### Useful ASAN Options

| Option          | Default     | Purpose                                      |
|-----------------|-------------|----------------------------------------------|
| `halt_on_error` | `1`         | Set to `0` to continue after the first error |
| `detect_leaks`  | `1` (Linux) | Enable leak detection at exit                |
| `log_path`      | stderr      | Write reports to `<path>.<pid>` files        |

### References
- [Clang documentation](https://clang.llvm.org/docs/AddressSanitizer.html)
- [GCC documentation](https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html)
- [MSVC documentation](https://learn.microsoft.com/en-us/cpp/sanitizers/asan?view=msvc-170)
