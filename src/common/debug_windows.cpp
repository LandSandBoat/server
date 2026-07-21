/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#ifdef _WIN32
#include <common/debug.h>
#include <common/tombstone.h>

#include <cpptrace/cpptrace.hpp>

#include <windows.h>

// dbghelp / shlobj must follow windows.h
#include <dbghelp.h>
#include <shlobj_core.h>

#include <atomic>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <vector>

namespace
{

DWORD  mainThreadId     = 0;
HANDLE mainThreadHandle = nullptr;

std::atomic<bool> minidumpEnabled{ false };

// SEH codes that must NOT be treated as crashes: pass them through to their real
// handlers with EXCEPTION_CONTINUE_SEARCH.
//   - 0xE24C4A00..05: LuaJIT throws/handles SEH as part of its normal runtime
//     (the codes are 0xE24C4A00 | LUA_OK..LUA_ERRERR); via Sol no Lua error is fatal.
//   - 0xE06D7363: the MSVC C++ exception code - an ordinary C++ `throw` (e.g. AI state
//     transitions) must not be reported as a crash.
constexpr auto isNonFatalException(DWORD code) -> bool
{
    switch (code)
    {
        case 0xE24C4A00: // LUA_OK
        case 0xE24C4A01: // LUA_YIELD
        case 0xE24C4A02: // LUA_ERRRUN
        case 0xE24C4A03: // LUA_ERRSYNTAX
        case 0xE24C4A04: // LUA_ERRMEM
        case 0xE24C4A05: // LUA_ERRERR
        case 0xE06D7363: // MSVC C++ exception
            return true;
        default:
            return false;
    }
}

constexpr auto exceptionName(DWORD code) -> const char*
{
    switch (code)
    {
        case EXCEPTION_ACCESS_VIOLATION:
            return "EXCEPTION_ACCESS_VIOLATION";
        case EXCEPTION_STACK_OVERFLOW:
            return "EXCEPTION_STACK_OVERFLOW";
        case EXCEPTION_ILLEGAL_INSTRUCTION:
            return "EXCEPTION_ILLEGAL_INSTRUCTION";
        case EXCEPTION_INT_DIVIDE_BY_ZERO:
            return "EXCEPTION_INT_DIVIDE_BY_ZERO";
        case EXCEPTION_FLT_DIVIDE_BY_ZERO:
            return "EXCEPTION_FLT_DIVIDE_BY_ZERO";
        case EXCEPTION_PRIV_INSTRUCTION:
            return "EXCEPTION_PRIV_INSTRUCTION";
        case EXCEPTION_IN_PAGE_ERROR:
            return "EXCEPTION_IN_PAGE_ERROR";
        default:
            return "structured-exception";
    }
}

auto filenameTimestamp() -> std::string
{
    SYSTEMTIME st;
    GetLocalTime(&st);
    char buf[32];
    std::snprintf(buf, sizeof(buf), "%04d%02d%02d_%02d%02d%02d", st.wYear, st.wMonth, st.wDay, st.wHour, st.wMinute, st.wSecond);
    return buf;
}

// Writes a .dmp minidump using the exact fault context. This MUST run inside the SEH
// filter, because MiniDumpWriteDump needs the EXCEPTION_POINTERS that Windows passes
// only here: cpptrace/the tombstone never have it. Returns the path (empty on error).
auto writeMiniDump(PEXCEPTION_POINTERS info) -> Maybe<std::string>
{
    CreateDirectoryA("dmp", nullptr);

    char path[MAX_PATH];
    std::snprintf(path, sizeof(path), "dmp\\tombstone_%lu_%s.dmp", GetCurrentProcessId(), filenameTimestamp().c_str());

    const auto hFile = CreateFileA(path, GENERIC_WRITE, 0, nullptr, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, nullptr);
    if (hFile == INVALID_HANDLE_VALUE)
    {
        return std::nullopt;
    }

    MINIDUMP_EXCEPTION_INFORMATION mei{};
    mei.ThreadId          = GetCurrentThreadId();
    mei.ExceptionPointers = info;
    mei.ClientPointers    = FALSE;

    const auto ok = MiniDumpWriteDump(
        GetCurrentProcess(), GetCurrentProcessId(), hFile, MiniDumpNormal, &mei, nullptr, nullptr);

    CloseHandle(hFile);
    if (!ok)
    {
        return std::nullopt;
    }

    return std::string(path);
}

LONG WINAPI unhandledExceptionFilter(PEXCEPTION_POINTERS info)
{
    const auto code = info->ExceptionRecord->ExceptionCode;

    if (isNonFatalException(code))
    {
        return EXCEPTION_CONTINUE_SEARCH;
    }

    if (debug::beginCrashReport())
    {
        // Write the minidump first (it snapshots all threads) when opted in, then capture the
        // main thread's stack for the tombstone (nullopt when the fault is on the main thread).
        const auto dumpPath  = minidumpEnabled.load(std::memory_order_acquire) ? writeMiniDump(info) : std::nullopt;
        const auto mainTrace = debug::captureMainThreadTrace();

        // The filter runs on the faulting thread's stack, so an ordinary unwind here
        // includes the fault frames (unlike a POSIX signal handler on an alt stack).
        tombstone::write({ .kind = exceptionName(code), .dumpLocation = dumpPath },
                         cpptrace::generate_trace(),
                         mainTrace);
    }

    // We've captured everything we need; terminate the process without the WER dialog.
    return EXCEPTION_EXECUTE_HANDLER;
}

} // namespace

void debug::init()
{
    debug::registerMainThread();

    SetUnhandledExceptionFilter(unhandledExceptionFilter);

    // Keep a headless server from blocking on the CRT abort() dialog (the terminate
    // handler calls abort() after writing its tombstone).
    _set_abort_behavior(0, _WRITE_ABORT_MSG | _CALL_REPORTFAULT);

    // Unhandled C++ exceptions -> tombstone.
    debug::installTerminateHandler();
}

void debug::setCoreDumpsEnabled(bool enabled)
{
    minidumpEnabled.store(enabled, std::memory_order_release);
}

auto debug::isRunningUnderDebugger() -> bool
{
    return IsDebuggerPresent();
}

auto debug::isUserRoot() -> bool
{
    // There is no root user on Windows, so we check for admin instead
    return IsUserAnAdmin();
}

auto debug::processId() -> int
{
    return static_cast<int>(GetCurrentProcessId());
}

auto debug::executablePath() -> Maybe<std::string>
{
    char       buf[MAX_PATH];
    const auto len = GetModuleFileNameA(nullptr, buf, static_cast<DWORD>(sizeof(buf)));
    if (len == 0)
    {
        return std::nullopt;
    }

    return std::string(buf, len);
}

auto debug::commandLine() -> Maybe<std::string>
{
    const auto cmd = GetCommandLineA();
    if (cmd == nullptr)
    {
        return std::nullopt;
    }

    return std::string(cmd);
}

auto debug::coreDumpHint() -> Maybe<std::string>
{
    // Windows has no core dump; the minidump is written by the SEH filter and its path
    // is reported directly (see unhandledExceptionFilter).
    return std::nullopt;
}

void debug::registerMainThread()
{
    mainThreadId = GetCurrentThreadId();

    // GetCurrentThread() is a pseudo-handle only valid on this thread; duplicate it into
    // a real handle another thread can suspend/inspect during a crash.
    DuplicateHandle(GetCurrentProcess(), GetCurrentThread(), GetCurrentProcess(), &mainThreadHandle, 0, FALSE, DUPLICATE_SAME_ACCESS);
}

auto debug::captureMainThreadTrace() -> Maybe<cpptrace::stacktrace>
{
    if (mainThreadHandle == nullptr || GetCurrentThreadId() == mainThreadId)
    {
        return std::nullopt;
    }

    if (SuspendThread(mainThreadHandle) == static_cast<DWORD>(-1))
    {
        return std::nullopt;
    }

    std::vector<cpptrace::frame_ptr> frames;

    CONTEXT ctx{};
    ctx.ContextFlags = CONTEXT_FULL;
    if (GetThreadContext(mainThreadHandle, &ctx))
    {
        STACKFRAME64 sf{};
        sf.AddrPC.Mode    = AddrModeFlat;
        sf.AddrFrame.Mode = AddrModeFlat;
        sf.AddrStack.Mode = AddrModeFlat;
#if defined(_M_ARM64)
        const auto machine  = IMAGE_FILE_MACHINE_ARM64;
        sf.AddrPC.Offset    = ctx.Pc;
        sf.AddrFrame.Offset = ctx.Fp;
        sf.AddrStack.Offset = ctx.Sp;
#else // _M_X64
        const auto machine  = IMAGE_FILE_MACHINE_AMD64;
        sf.AddrPC.Offset    = ctx.Rip;
        sf.AddrFrame.Offset = ctx.Rbp;
        sf.AddrStack.Offset = ctx.Rsp;
#endif
        const auto process = GetCurrentProcess();
        for (int i = 0; i < 256; ++i)
        {
            if (!StackWalk64(machine, process, mainThreadHandle, &sf, &ctx, nullptr, SymFunctionTableAccess64, SymGetModuleBase64, nullptr) ||
                sf.AddrPC.Offset == 0)
            {
                break;
            }
            frames.push_back(static_cast<cpptrace::frame_ptr>(sf.AddrPC.Offset));
        }
    }

    ResumeThread(mainThreadHandle);

    cpptrace::raw_trace raw;
    raw.frames = std::move(frames);

    auto stack = raw.resolve();
    if (stack.empty())
    {
        return std::nullopt;
    }

    return stack;
}

#endif // _WIN32
