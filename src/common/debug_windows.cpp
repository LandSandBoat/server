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
#include "debug.h"
#include "tombstone.h"

#include <cpptrace/cpptrace.hpp>

#define WIN32_LEAN_AND_MEAN
#define NOMINMAX
#include <windows.h>

// dbghelp / shlobj must follow windows.h
#include <dbghelp.h>
#include <shlobj_core.h>

#include <cstdio>
#include <cstdlib>
#include <string>

namespace
{

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
auto writeMiniDump(PEXCEPTION_POINTERS info) -> std::string
{
    CreateDirectoryA("dmp", nullptr);

    char path[MAX_PATH];
    std::snprintf(path, sizeof(path), "dmp\\tombstone_%lu_%s.dmp", GetCurrentProcessId(), filenameTimestamp().c_str());

    const HANDLE hFile = CreateFileA(path, GENERIC_WRITE, 0, nullptr, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, nullptr);
    if (hFile == INVALID_HANDLE_VALUE)
    {
        return {};
    }

    MINIDUMP_EXCEPTION_INFORMATION mei{};
    mei.ThreadId          = GetCurrentThreadId();
    mei.ExceptionPointers = info;
    mei.ClientPointers    = FALSE;

    const BOOL ok = MiniDumpWriteDump(
        GetCurrentProcess(), GetCurrentProcessId(), hFile, MiniDumpNormal, &mei, nullptr, nullptr);

    CloseHandle(hFile);
    return ok ? std::string(path) : std::string();
}

LONG WINAPI unhandledExceptionFilter(PEXCEPTION_POINTERS info)
{
    const DWORD code = info->ExceptionRecord->ExceptionCode;

    if (isNonFatalException(code))
    {
        return EXCEPTION_CONTINUE_SEARCH;
    }

    if (debug::beginCrashReport())
    {
        const std::string dumpPath = writeMiniDump(info);
        const std::string detail   = dumpPath.empty() ? std::string() : ("minidump: " + dumpPath);

        // The filter runs on the faulting thread's stack, so an ordinary unwind here
        // includes the fault frames (unlike a POSIX signal handler on an alt stack).
        tombstone::write({ .kind = exceptionName(code), .detail = detail }, cpptrace::generate_trace());
    }

    // We've captured everything we need; terminate the process without the WER dialog.
    return EXCEPTION_EXECUTE_HANDLER;
}

} // namespace

void debug::init()
{
    SetUnhandledExceptionFilter(unhandledExceptionFilter);

    // Keep a headless server from blocking on the CRT abort() dialog (the terminate
    // handler calls abort() after writing its tombstone).
    _set_abort_behavior(0, _WRITE_ABORT_MSG | _CALL_REPORTFAULT);

    // Unhandled C++ exceptions -> tombstone.
    debug::installTerminateHandler();
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

auto debug::executablePath() -> std::string
{
    char        buf[MAX_PATH];
    const DWORD len = GetModuleFileNameA(nullptr, buf, static_cast<DWORD>(sizeof(buf)));
    return std::string(buf, len);
}

auto debug::commandLine() -> std::string
{
    const char* const cmd = GetCommandLineA();
    return cmd != nullptr ? std::string(cmd) : std::string{};
}

#endif // _WIN32
