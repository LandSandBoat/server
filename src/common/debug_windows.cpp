#include "debug.h"

#include "logging.h"
#include "spdlog/fmt/fmt.h"

#include <DbgHelp.h>
#include <Windows.h>
#include <Shlwapi.h>

#include <string>

namespace debug
{
std::string SystemErrorToString(DWORD errorCode)
{
    std::string errorString = "UNKNOWN";
    // clang-format off
    switch (errorCode)
    {
        // WinDbg
        case 0x00000000: errorString = "STATUS_WAIT_0"; break;
        case 0x00000080: errorString = "STATUS_ABANDONED_WAIT_0"; break;
        case 0x000000C0: errorString = "STATUS_USER_APC"; break;
        case 0x00000102: errorString = "STATUS_TIMEOUT"; break;
        case 0x00000103: errorString = "STATUS_PENDING"; break;
        case 0x00010001: errorString = "DBG_EXCEPTION_HANDLED"; break;
        case 0x00010002: errorString = "DBG_CONTINUE"; break;
        case 0x40000005: errorString = "STATUS_SEGMENT_NOTIFICATION"; break;
        case 0x40000015: errorString = "STATUS_FATAL_APP_EXIT"; break;
        case 0x40010001: errorString = "DBG_REPLY_LATER"; break;
        case 0x40010003: errorString = "DBG_TERMINATE_THREAD"; break;
        case 0x40010004: errorString = "DBG_TERMINATE_PROCESS"; break;
        case 0x40010005: errorString = "DBG_CONTROL_C"; break;
        case 0x40010006: errorString = "DBG_PRINTEXCEPTION_C"; break;
        case 0x40010007: errorString = "DBG_RIPEXCEPTION"; break;
        case 0x40010008: errorString = "DBG_CONTROL_BREAK"; break;
        case 0x40010009: errorString = "DBG_COMMAND_EXCEPTION"; break;
        case 0x4001000A: errorString = "DBG_PRINTEXCEPTION_WIDE_C"; break;
        case 0x80000001: errorString = "STATUS_GUARD_PAGE_VIOLATION"; break;
        case 0x80000002: errorString = "STATUS_DATATYPE_MISALIGNMENT"; break;
        case 0x80000003: errorString = "STATUS_BREAKPOINT"; break;
        case 0x80000004: errorString = "STATUS_SINGLE_STEP"; break;
        case 0x80000026: errorString = "STATUS_LONGJUMP"; break;
        case 0x80000029: errorString = "STATUS_UNWIND_CONSOLIDATE"; break;
        case 0x80010001: errorString = "DBG_EXCEPTION_NOT_HANDLED"; break;
        case 0xC0000005: errorString = "STATUS_ACCESS_VIOLATION"; break;
        case 0xC0000006: errorString = "STATUS_IN_PAGE_ERROR"; break;
        case 0xC0000008: errorString = "STATUS_INVALID_HANDLE"; break;
        case 0xC000000D: errorString = "STATUS_INVALID_PARAMETER"; break;
        case 0xC0000017: errorString = "STATUS_NO_MEMORY"; break;
        case 0xC000001D: errorString = "STATUS_ILLEGAL_INSTRUCTION"; break;
        case 0xC0000025: errorString = "STATUS_NONCONTINUABLE_EXCEPTION"; break;
        case 0xC0000026: errorString = "STATUS_INVALID_DISPOSITION"; break;
        case 0xC000008C: errorString = "STATUS_ARRAY_BOUNDS_EXCEEDED"; break;
        case 0xC000008D: errorString = "STATUS_FLOAT_DENORMAL_OPERAND"; break;
        case 0xC000008E: errorString = "STATUS_FLOAT_DIVIDE_BY_ZERO"; break;
        case 0xC000008F: errorString = "STATUS_FLOAT_INEXACT_RESULT"; break;
        case 0xC0000090: errorString = "STATUS_FLOAT_INVALID_OPERATION"; break;
        case 0xC0000091: errorString = "STATUS_FLOAT_OVERFLOW"; break;
        case 0xC0000092: errorString = "STATUS_FLOAT_STACK_CHECK"; break;
        case 0xC0000093: errorString = "STATUS_FLOAT_UNDERFLOW"; break;
        case 0xC0000094: errorString = "STATUS_INTEGER_DIVIDE_BY_ZERO"; break;
        case 0xC0000095: errorString = "STATUS_INTEGER_OVERFLOW"; break;
        case 0xC0000096: errorString = "STATUS_PRIVILEGED_INSTRUCTION"; break;
        case 0xC00000FD: errorString = "STATUS_STACK_OVERFLOW"; break;
        case 0xC0000135: errorString = "STATUS_DLL_NOT_FOUND"; break;
        case 0xC0000138: errorString = "STATUS_ORDINAL_NOT_FOUND"; break;
        case 0xC0000139: errorString = "STATUS_ENTRYPOINT_NOT_FOUND"; break;
        case 0xC000013A: errorString = "STATUS_CONTROL_C_EXIT"; break;
        case 0xC0000142: errorString = "STATUS_DLL_INIT_FAILED"; break;
        case 0xC00001B2: errorString = "STATUS_CONTROL_STACK_VIOLATION"; break;
        case 0xC00002B4: errorString = "STATUS_FLOAT_MULTIPLE_FAULTS"; break;
        case 0xC00002B5: errorString = "STATUS_FLOAT_MULTIPLE_TRAPS"; break;
        case 0xC00002C9: errorString = "STATUS_REG_NAT_CONSUMPTION"; break;
        case 0xC0000374: errorString = "STATUS_HEAP_CORRUPTION"; break;
        case 0xC0000409: errorString = "STATUS_STACK_BUFFER_OVERRUN"; break;
        case 0xC0000417: errorString = "STATUS_INVALID_CRUNTIME_PARAMETER"; break;
        case 0xC0000420: errorString = "STATUS_ASSERTION_FAILURE"; break;
        case 0xC00004A2: errorString = "STATUS_ENCLAVE_VIOLATION"; break;
        case 0xC0000515: errorString = "STATUS_INTERRUPTED"; break;
        case 0xC0000516: errorString = "STATUS_THREAD_NOT_RUNNING"; break;
        case 0xC0000718: errorString = "STATUS_ALREADY_REGISTERED"; break;
        case 0xC015000F: errorString = "STATUS_SXS_EARLY_DEACTIVATION"; break;
        case 0xC0150010: errorString = "STATUS_SXS_INVALID_DEACTIVATION"; break;
    }
    // clang-format on

    return fmt::format("{} ({:#08X})", errorString, errorCode);
}

std::string getExeFilename()
{
    char buf[MAX_PATH];
    GetModuleFileNameA(nullptr, buf, MAX_PATH);
    return PathFindFileName(buf);
}

// https://stackoverflow.com/a/50208684
// From MSDN.WhiteKnight
LONG WINAPI TopLevelExceptionHandler(PEXCEPTION_POINTERS pExceptionInfo)
{
    // https://www.freelists.org/post/luajit/FirstChance-Exception-in-luajit,1
    // https://love2d.org/forums/viewtopic.php?t=84336
    switch (pExceptionInfo->ExceptionRecord->ExceptionCode)
    {
       // LuaJIT throws and handles exceptions as part of its regular runtime.
       // We should ignore these. By using Sol, there is no scenario where we want a Lua error to be fatal.
       // The LuaJIT exception codes are all built by OR-ing 0xE24C4A00 with the relevant Lua error codes:
       // https://github.com/LuaJIT/LuaJIT/blob/4deb5a1588ed53c0c578a343519b5ede59f3d928/src/lj_err.c#L250-L256
       // https://github.com/LuaJIT/LuaJIT/blob/20f556e53190ab9a735b932f5d868d45ec536a70/src/lua.h#L42-L48
        case 0xE24C4A00: // LUA_OK (0)
            [[fallthrough]];
        case 0xE24C4A01: // LUA_YIELD (1)
            [[fallthrough]];
        case 0xE24C4A02: // LUA_ERRRUN (2)
            [[fallthrough]];
        case 0xE24C4A03: // LUA_ERRSYNTAX (3)
            [[fallthrough]];
        case 0xE24C4A04: // LUA_ERRMEM (4)
            [[fallthrough]];
        case 0xE24C4A05: // LUA_ERRERR (5)
            return EXCEPTION_CONTINUE_SEARCH;

        // Exceptions thrown internally (like is possible in AI state transitions) should also be ignored
        case 0xE06D7363: // Internal application exception code
            return EXCEPTION_CONTINUE_SEARCH;

        default:
            break;
    }

    // Create dump
    // https://docs.microsoft.com/en-gb/windows/win32/dxtecharts/crash-dump-analysis

    auto exeName = getExeFilename();
    std::time_t t = std::time(nullptr);
    auto timeStr = fmt::format("{:%Y_%m_%d_%H_%M_%S}", fmt::localtime(t));
    auto dumpName = fmt::format(".\\dmp\\{}_{}.dmp", getExeFilename(), timeStr);

    BOOL bMiniDumpSuccessful;
    HANDLE hDumpFile;
    MINIDUMP_EXCEPTION_INFORMATION ExpParam;

    hDumpFile = CreateFileA(dumpName.c_str(), GENERIC_READ|GENERIC_WRITE,
                FILE_SHARE_WRITE|FILE_SHARE_READ, 0, CREATE_ALWAYS, 0, 0);

    ExpParam.ThreadId = GetCurrentThreadId();
    ExpParam.ExceptionPointers = pExceptionInfo;
    ExpParam.ClientPointers = TRUE;

    bMiniDumpSuccessful = MiniDumpWriteDump(GetCurrentProcess(), GetCurrentProcessId(),
                    hDumpFile, (_MINIDUMP_TYPE)(MiniDumpWithDataSegs | MiniDumpWithFullMemory), &ExpParam, NULL, NULL);

    // A fatal event has occured, from this point on all code executed comes from our error handling.
    // We no longer need to trace where each log comes from, so change to a cleaner pattern.
    spdlog::set_pattern(fmt::format("[%D %T:%e][{}]%^[%l][%n]%$ %v", exeName));

    ShowFatalError("Exception %s occured!", SystemErrorToString(pExceptionInfo->ExceptionRecord->ExceptionCode));

    CONTEXT* ctx = pExceptionInfo->ContextRecord;

    BOOL    result;
    HANDLE  process;
    HANDLE  thread;
    HMODULE hModule;

    STACKFRAME64 stack;
    ULONG        frame;
    DWORD64      displacement;

    DWORD            disp;
    IMAGEHLP_LINE64* line;

    char         buffer[sizeof(SYMBOL_INFO) + MAX_SYM_NAME * sizeof(TCHAR)];
    char         name[256];
    char         module[256];
    PSYMBOL_INFO pSymbol = (PSYMBOL_INFO)buffer;

    memset(&stack, 0, sizeof(STACKFRAME64));

    process      = GetCurrentProcess();
    thread       = GetCurrentThread();
    displacement = 0;
#if !defined(_M_AMD64)
    stack.AddrPC.Offset    = (*ctx).Eip;
    stack.AddrPC.Mode      = AddrModeFlat;
    stack.AddrStack.Offset = (*ctx).Esp;
    stack.AddrStack.Mode   = AddrModeFlat;
    stack.AddrFrame.Offset = (*ctx).Ebp;
    stack.AddrFrame.Mode   = AddrModeFlat;
#endif

    SymInitialize(process, NULL, TRUE); // load symbols

    for (frame = 0;; frame++)
    {
        // get next call from stack
        result = StackWalk64(
#if defined(_M_AMD64)
            IMAGE_FILE_MACHINE_AMD64
#else
            IMAGE_FILE_MACHINE_I386
#endif
            ,
            process,
            thread,
            &stack,
            ctx,
            NULL,
            SymFunctionTableAccess64,
            SymGetModuleBase64,
            NULL);

        if (!result)
        {
            break;
        }

        // get symbol name for address
        pSymbol->SizeOfStruct = sizeof(SYMBOL_INFO);
        pSymbol->MaxNameLen   = MAX_SYM_NAME;
        SymFromAddr(process, (ULONG64)stack.AddrPC.Offset, &displacement, pSymbol);

        line               = (IMAGEHLP_LINE64*)malloc(sizeof(IMAGEHLP_LINE64));
        line->SizeOfStruct = sizeof(IMAGEHLP_LINE64);

        // try to get line
        if (SymGetLineFromAddr64(process, stack.AddrPC.Offset, &disp, line))
        {
            ShowStacktrace("\tat %s in %s: line: %lu: address: 0x%0X", pSymbol->Name, line->FileName, line->LineNumber, pSymbol->Address);
        }
        else
        {
            // failed to get line
            ShowStacktrace("\tat %s, address 0x%0X.", pSymbol->Name, pSymbol->Address);
            hModule = NULL;
            lstrcpyA(module, "");
            GetModuleHandleEx(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                              (LPCTSTR)(stack.AddrPC.Offset), &hModule);

            // at least print module name
            if (hModule != NULL)
            {
                GetModuleFileNameA(hModule, module, 256);
            }

            ShowStacktrace("in %s", module);
        }

        free(line);
        line = NULL;
    }
    return EXCEPTION_CONTINUE_SEARCH;
}

void init()
{
    // Get rid of the "Debug Assertion Failed" popup, so that
    // our own error handling code can run uninterrupted.
    _CrtSetReportMode(_CRT_WARN, _CRTDBG_MODE_DEBUG);
    _CrtSetReportMode(_CRT_ERROR, _CRTDBG_MODE_DEBUG);
    _CrtSetReportMode(_CRT_ASSERT, _CRTDBG_MODE_DEBUG);

    AddVectoredExceptionHandler(1, TopLevelExceptionHandler);
}
} // namespace debug
