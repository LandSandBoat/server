#include "debug.h"

#include "WheatyExceptionReport.h"

WheatyExceptionReport g_WheatyExceptionReport;

void debug::init()
{
    g_WheatyExceptionReport = WheatyExceptionReport();
}

bool debug::isRunningUnderDebugger()
{
    return IsDebuggerPresent();
}
