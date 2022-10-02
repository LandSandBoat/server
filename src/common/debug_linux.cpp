#include <csignal>

#include "debug.h"
#include "kernel.h"

#define BACKWARD_HAS_BFD 1
#include "../../ext/backward/backward.hpp"

void dumpBacktrace(int signal)
{
    ShowCritical("Crash detected, generating traceback (this may take a while)");

    backward::StackTrace trace;
    backward::Printer    printer;

    trace.load_here(32);

    printer.object     = true;
    printer.color_mode = backward::ColorMode::always;
    printer.address    = true;

    std::ostringstream traceStream;
    printer.print(trace, traceStream);
    spdlog::get("critical")->critical(traceStream.str());

    do_final(EXIT_FAILURE);

#ifdef _DEBUG
    std::signall(sn, SIG_DFL);
    raise(sn); // reraise and pass to OS in debug mode
#endif
}

void debug::init()
{
    // things we want to handle
    std::signal(SIGABRT, dumpBacktrace);
    std::signal(SIGSEGV, dumpBacktrace);
    std::signal(SIGFPE, dumpBacktrace);
    std::signal(SIGXFSZ, dumpBacktrace);

    // pass these onto default handler
    std::signal(SIGILL, SIG_DFL);
    std::signal(SIGBUS, SIG_DFL);
    std::signal(SIGTRAP, SIG_DFL);
}
