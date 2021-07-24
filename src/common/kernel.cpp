/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "../common/kernel.h"
#include "../common/logging.h"
#include "../common/socket.h"
#include "../common/taskmgr.h"
#include "../common/timer.h"
#include "../common/version.h"

#include "logging.h"
#include <csignal>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#ifdef WIN32 // For stack trace tools
#include <DbgHelp.h>
#include <Windows.h>
#endif

#ifndef _WIN32
#include <unistd.h>
#endif

#ifdef __linux__
#include <linux/version.h>
#include <sys/wait.h>
#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 4, 0)
#include <sys/prctl.h>
#define HAS_YAMA_PRCTL
#endif
#endif

int    runflag = 1;
int    arg_c   = 0;
char** arg_v   = nullptr;

char* SERVER_NAME = nullptr;
char  SERVER_TYPE = XI_SERVER_NONE;

// Copyright (c) Athena Dev Teams
// Added by Gabuzomeu
//
// This is an implementation of signal() using sigaction() for portability.
// (sigaction() is POSIX; signal() is not.)  Taken from Stevens' _Advanced
// Programming in the UNIX Environment_.

#ifdef WIN32 // windows don't have SIGPIPE
#define SIGPIPE SIGINT
#endif

#ifndef POSIX
#define compat_signal(signo, func) signal(signo, func)
#else
sigfunc* compat_signal(int signo, sigfunc* func)
{
    struct sigaction sact, oact;

    sact.sa_handler = func;
    sigemptyset(&sact.sa_mask);
    sact.sa_flags = 0;
#ifdef SA_INTERRUPT
    sact.sa_flags |= SA_INTERRUPT; /* SunOS */
#endif

    if (sigaction(signo, &sact, &oact) < 0)
        return (SIG_ERR);

    return (oact.sa_handler);
}
#endif

/************************************************************************
 *                                                                       *
 *  CORE : Magical backtrace dump procedure (Linux + gdb)                *
 *                                                                       *
 ************************************************************************/

static void dump_backtrace()
{
    // gdb
#if defined(__linux__)
    int fd[2];
    int status = pipe(fd);
    if (status == -1)
    {
        ShowError("pipe failed for gdb backtrace: %s", strerror(errno));
        _exit(EXIT_FAILURE);
    }
    pid_t child_pid = fork();

#ifdef HAS_YAMA_PRCTL
    // Tell yama that we allow our child_pid to trace our process
    if (child_pid > 0)
    {
        prctl(PR_SET_DUMPABLE, 1);
        prctl(PR_SET_PTRACER, child_pid);
    }
#endif

    if (child_pid < 0)
    {
        ShowError("Fork failed for gdb backtrace");
    }
    else if (child_pid == 0)
    {
        // NOTE: gdb-7.8 has regression, either update or downgrade.
        close(fd[0]);
        char buf[255];
        snprintf(buf, sizeof(buf), "gdb -p %d -n -batch -ex generate-core-file -ex bt 2>/dev/null 1>&%d", getppid(), fd[1]);
        execl("/bin/sh", "/bin/sh", "-c", buf, NULL);
        ShowError("Failed to launch gdb for backtrace");
        _exit(EXIT_FAILURE);
    }
    else
    {
        close(fd[1]);
        waitpid(child_pid, nullptr, 0);
        char buf[4096] = { 0 };
        status         = read(fd[0], buf, sizeof(buf) - 1);
        if (status == -1)
        {
            ShowError("read failed for gdb backtrace: %s", strerror(errno));
            _exit(EXIT_FAILURE);
        }
        ShowFatalError("--- gdb backtrace ---");
        ShowFatalError("%s", buf);
    }
#endif
}

/************************************************************************
 *                                                                       *
 *  CORE : Magical backtrace dump procedure (Windows)                    *
 *                                                                       *
 ************************************************************************/

#ifdef WIN32
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

        // Other
        case 0xE06D7363: errorString = "UNKNOWN_APPLICATION_ERROR"; break; // TODO: What is the name for 0XE06D7363?
    }
    // clang-format on

    return fmt::format("{} ({:#08X})", errorString, errorCode);
}

// https://stackoverflow.com/a/50208684
// From MSDN.WhiteKnight
LONG WINAPI TopLevelExceptionHandler(PEXCEPTION_POINTERS pExceptionInfo)
{
    // https://www.freelists.org/post/luajit/FirstChance-Exception-in-luajit,1
    // https://love2d.org/forums/viewtopic.php?t=84336
    switch (pExceptionInfo->ExceptionRecord->ExceptionCode)
    {
        // exceptions NOT documented by Microsoft
        case 0xE24C4A02 : // Magic exception number from LuaJIT: Ignore!
            return EXCEPTION_CONTINUE_SEARCH;

        default:
            break;
    }

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
#endif // WIN32

/************************************************************************
 *																		*
 *  CORE : Signal Sub Function											*
 *																		*
 ************************************************************************/

static void sig_proc(int sn)
{
    static int is_called = 0;

    switch (sn)
    {
        case SIGINT:
        case SIGTERM:
            if (++is_called > 3)
            {
                do_final(EXIT_SUCCESS);
            }
            runflag = 0;
            break;
        case SIGABRT:
        case SIGSEGV:
        case SIGFPE:
            dump_backtrace();
            do_abort();
            // Pass the signal to the system's default handler
            compat_signal(sn, SIG_DFL);
            raise(sn);
            break;
#ifndef _WIN32
        case SIGXFSZ:
            // ignore and allow it to set errno to EFBIG
            ShowWarning("Max file size reached!");
            // run_flag = 0;	// should we quit?
            break;
        case SIGPIPE:
            // ShowInfo ("Broken pipe found... closing socket");	// set to eof in socket.c
            break; // does nothing here
#endif
    }
}

/************************************************************************
 *																		*
 *																		*
 *																		*
 ************************************************************************/

void signals_init()
{
    compat_signal(SIGTERM, sig_proc);
    compat_signal(SIGINT, sig_proc);
#ifndef _DEBUG // need unhandled exceptions to debug on Windows
    compat_signal(SIGABRT, sig_proc);
    compat_signal(SIGSEGV, sig_proc);
    compat_signal(SIGFPE, sig_proc);
#endif
#ifndef _WIN32
    compat_signal(SIGILL, SIG_DFL);
    compat_signal(SIGXFSZ, sig_proc);
    compat_signal(SIGPIPE, sig_proc);
    compat_signal(SIGBUS, SIG_DFL);
    compat_signal(SIGTRAP, SIG_DFL);
#endif
}

/************************************************************************
 *																		*
 *  Warning if logged in as superuser (root)								*
 *																		*
 ************************************************************************/

void usercheck()
{
#ifndef _WIN32
    if ((getuid() == 0) && (getgid() == 0))
    {
        ShowWarning("You are running as the root superuser.");
        ShowWarning("It is unnecessary and unsafe to run with root privileges.");
        sleep(3);
    }
#endif
}

/************************************************************************
 *																		*
 *  CORE : MAINROUTINE													*
 *																		*
 ************************************************************************/
#ifndef DEFINE_OWN_MAIN
int main(int argc, char** argv)
{
#ifdef WIN32
    AddVectoredExceptionHandler(1, TopLevelExceptionHandler);
#endif

    { // initialize program arguments
        char* p1 = SERVER_NAME = argv[0];
        char* p2               = p1;
        while ((p1 = strchr(p2, '/')) != nullptr || (p1 = strchr(p2, '\\')) != nullptr)
        {
            SERVER_NAME = ++p1;
            p2          = p1;
        }
        arg_c = argc;
        arg_v = argv;
    }

    log_init(argc, argv);
    set_server_type();
    usercheck();
    signals_init();
    timer_init();
    socket_init();

    do_init(argc, argv);
    fd_set rfd;
    { // Main runtime cycle
        duration next;

        while (runflag)
        {
            next = CTaskMgr::getInstance()->DoTimer(server_clock::now());
            do_sockets(&rfd, next);
        }
    }

    do_final(EXIT_SUCCESS);
    return 0;
}
#endif