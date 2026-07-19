/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

//
// Tombstone
//
//   A "tombstone" is a single, heavily annotated crash-log file: the reason for
//   the crash, build/version and process context, the recent log breadcrumb, and a
//   symbolized stack trace. It is the cross-platform companion to the OS crash
//   artifact (a core dump on POSIX, a .dmp minidump on Windows).
//

#include <common/types/maybe.h>

#include <cpptrace/cpptrace.hpp>

#include <string>

namespace tombstone
{

struct Reason
{
    std::string        kind;         // short tag, e.g. "SIGSEGV", "unhandled-exception", "watchdog"
    Maybe<std::string> detail;       // human-readable: signal description, exception what(), etc.
    Maybe<std::string> dumpLocation; // where the OS core / minidump is (or a hint to find it)
};

// Records an approximate process-start time for the "Uptime" field.
void markStartTime();

// Build the annotated tombstone report as a string. Performs no I/O.
[[nodiscard]] auto build(const Reason& reason, const cpptrace::stacktrace& trace, const Maybe<cpptrace::stacktrace>& mainThreadTrace = std::nullopt) -> std::string;

// Build and write the report to `dmp/tombstone_<pid>_<timestamp>.log`, and
// always mirror the full report to stderr (via fwrite, so it survives even a wedged
// logging stack). Returns the path written, or an empty string on failure.
//
// NOTE: This allocates and touches the filesystem, so it is NOT async-signal-safe.
auto write(const Reason& reason, const cpptrace::stacktrace& trace, const Maybe<cpptrace::stacktrace>& mainThreadTrace = std::nullopt) -> std::string;

} // namespace tombstone
