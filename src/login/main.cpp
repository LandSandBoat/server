/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "connect_application.h"

// openssl applink.c prevents issues with debug vs release vs threaded/single threaded .dlls at runtime
// apparently not an issue with linux
#ifdef _WIN32
#include <ms/applink.c>
#endif

int main(int argc, char** argv)
{
    const auto connectApp = std::make_unique<ConnectApplication>(argc, argv);

    connectApp->run();

    return 0;
}
