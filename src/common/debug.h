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

#pragma once

#include <common/types/maybe.h>

#include <cpptrace/cpptrace.hpp>

#include <string>

namespace debug
{

void init();

void setCoreDumpsEnabled(bool enabled);

// https://forum.juce.com/t/detecting-if-a-process-is-being-run-under-a-debugger/2098
auto isRunningUnderDebugger() -> bool;

auto isUserRoot() -> bool;

// The current process id. Platform-specific.
auto processId() -> int;

// Canonical full path to the running executable (nullopt on failure). Platform-specific.
auto executablePath() -> Maybe<std::string>;

// The full invocation - executable plus all arguments (nullopt on failure). Platform-specific.
auto commandLine() -> Maybe<std::string>;

// Where the OS core dump can be found, or a hint for retrieving it (nullopt if none is
// expected). POSIX only; Windows returns nullopt since its minidump path is reported
// directly by the crash filter.
auto coreDumpHint() -> Maybe<std::string>;

// One-shot crash-report guard. Returns true only for the FIRST caller; every later
// caller gets false.
auto beginCrashReport() -> bool;

// Installs a std::terminate handler that writes a tombstone for unhandled C++
// exceptions. Cross-platform; invoked by each platform's init().
void installTerminateHandler();

// Records the calling thread as the "main" thread and installs the machinery used to
// capture its stack from another thread during a crash.
void registerMainThread();

// Captures the main thread's stack, for a crash that originated on another thread so
// the tombstone can show what the main thread was doing.
auto captureMainThreadTrace() -> Maybe<cpptrace::stacktrace>;

} // namespace debug
