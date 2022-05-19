/*
===========================================================================

Copyright (c) 2022 LandSandBoat Dev Teams

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
#include "world_server.h"

int main(int argc, char** argv)
{
    auto argParser = std::make_unique<argparse::ArgumentParser>(argv[0]);

    try
    {
        argParser->parse_args(argc, argv);
    }
    catch (const std::runtime_error& err)
    {
        std::cerr << err.what() << std::endl;
        std::cerr << *argParser;
        std::exit(1);
    }

    auto pWorldServer = std::make_unique<WorldServer>(std::move(argParser));

    while (pWorldServer->IsRunning())
    {
        pWorldServer->Tick();
    }

    return 0;
}