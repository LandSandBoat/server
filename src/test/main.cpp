/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include <test/test_application.h>

#include <common/lua.h>
#include <common/settings.h>
#include <common/tracy.h>

#include <catch2/catch_session.hpp>

#include <iostream>
#include <memory>

int main(int argc, char** argv)
{
    TracySetThreadName("Test Thread");

    // Run the Catch2 C++ unit tests first: they're fast, need no DB or engine,
    // and a failure means a core container/type invariant is broken - there's
    // no point booting the Lua suite on top of that. xi_test's own CLI flags
    // aren't valid Catch2 arguments, so the session runs everything registered.
    {
        // Entity constructors read settings (BASE_SPEED etc.), which normally
        // load in Application's constructor - and settings load through the
        // global lua state. Both inits are idempotent; TestApplication re-runs
        // them later.
        lua_init();
        settings::init();
        std::cout << "[----------] Running C++ unit tests (Catch2)" << std::endl;

        const char* catchArgv[] = { argv[0] };
        if (Catch::Session().run(1, const_cast<char**>(catchArgv)) != 0)
        {
            std::cerr << "C++ unit tests failed; skipping the Lua test suite." << std::endl;
            return EXIT_FAILURE;
        }
    }

    auto testApp = std::make_unique<TestApplication>(argc, argv);

    const auto success = testApp->run();

    const auto exitCode = success ? EXIT_SUCCESS : EXIT_FAILURE;

    // Explicitly destroy TestApplication before the lua state get cleaned up
    testApp.reset();

    // TODO: This should be in ~Application but it needs more testing for xi_map
    // TODO: This wouldn't be needed if lua wasn't global
    lua_cleanup();

#ifdef TRACY_ENABLE
    // TODO: Tracy profiler exits when program is done
    // Is there an option to keep it running despite the program exiting?
    std::cout << "Press Enter to exit..." << std::endl;
    std::cin.get();
#endif

    return exitCode;
}
