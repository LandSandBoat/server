#ifdef _WIN32
#include "debug.h"

#include "WheatyExceptionReport.h"

#include <shlobj_core.h>

WheatyExceptionReport g_WheatyExceptionReport;

void debug::init()
{
    g_WheatyExceptionReport = WheatyExceptionReport();
}

bool debug::isRunningUnderDebugger()
{
    return IsDebuggerPresent();
}

bool debug::isUserRoot()
{
    // There is no root user on Windows, so we check for admin instead
    return IsUserAnAdmin();
}

#endif // _WIN32
