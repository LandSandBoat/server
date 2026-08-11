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

//
// Entry point for xi_unit_test, the standalone bench for tests that need only src/common.
//
// The bench runs without booting a server, so nothing has set up the pieces that src/common
// expects to already exist. Two are needed:
//
//   - logging, because the code under test reports failures through ShowError/ShowCritical, and
//     those dereference a logger that InitializeLog resolves.
//   - settings, because entities read them on construction and would otherwise log an error per
//     lookup and fall back to a zeroed default. Settings are Lua files, so the Lua state has to
//     come up first, in the same order Application uses.
//

#include <common/logging.h>
#include <common/lua.h>
#include <common/settings.h>

#include <catch2/catch_session.hpp>

auto main(int argc, char** argv) -> int
{
    logging::InitializeLog("unit_test", "log/unit_test.log", false);

    lua_init();
    settings::init();

    const auto result = Catch::Session().run(argc, argv);

    lua_cleanup();
    logging::ShutDown();

    return result;
}
