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

#include <common/debug.h>

#include <common/tombstone.h>

#include <cpptrace/cpptrace.hpp>

#include <fmt/format.h>

#include <atomic>
#include <cstdlib>
#include <exception>
#include <typeinfo>

namespace
{

std::atomic<bool> crashReported{ false };

[[noreturn]] void terminateHandler()
{
    // Only the first reporter writes a tombstone; the abort() below re-enters via
    // SIGABRT, and that handler will see the guard already set and just dump core.
    if (debug::beginCrashReport())
    {
        auto reason = tombstone::Reason{ .kind = "unhandled-exception", .detail = "terminate called without an active exception", .dumpLocation = debug::coreDumpHint() };

        if (const auto eptr = std::current_exception())
        {
            try
            {
                std::rethrow_exception(eptr);
            }
            catch (const std::exception& e)
            {
                reason.detail = fmt::format("{}: {}", cpptrace::demangle(typeid(e).name()), e.what());
            }
            catch (...)
            {
                reason.detail = "non-std exception thrown";
            }
        }

        // For a genuinely uncaught exception the stack is typically not unwound yet, so
        // this trace is close to the throw site. captureMainThreadTrace() adds the main
        // thread's stack when the throw escaped a worker (nullopt otherwise). Not a signal
        // context, so full symbolization (which may spawn atos/addr2line) is safe here.
        tombstone::write(reason, cpptrace::generate_trace(), debug::captureMainThreadTrace());
    }

    std::abort();
}

} // namespace

auto debug::beginCrashReport() -> bool
{
    auto expected = false;
    return crashReported.compare_exchange_strong(expected, true);
}

void debug::installTerminateHandler()
{
    std::set_terminate(terminateHandler);
}
