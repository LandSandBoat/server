#pragma once

namespace debug
{
    void init();

    // https://forum.juce.com/t/detecting-if-a-process-is-being-run-under-a-debugger/2098
    bool isRunningUnderDebugger();
} // namespace debug
