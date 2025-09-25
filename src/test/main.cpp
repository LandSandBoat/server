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

#include "common/lua.h"
#include "test_application.h"

#include <memory>

int main(int argc, char** argv)
{
    auto testApp = std::make_unique<TestApplication>(argc, argv);

    testApp->run();

    // Explicitly destroy TestApplication before the lua state get cleaned up
    testApp.reset();

    // TODO: This should be in ~Application but it needs more testing for xi_map
    // TODO: This wouldn't be needed if lua wasn't global
    lua_cleanup();

    return 0;
}
