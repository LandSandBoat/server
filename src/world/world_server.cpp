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

#include "common/application.h"
#include "common/console_service.h"
#include "common/logging.h"

WorldServer::WorldServer(int argc, char** argv)
: Application("world", argc, argv)
, messageServer(std::make_unique<message_server_wrapper_t>(std::ref(m_RequestExit)))
, httpServer(std::make_unique<HTTPServer>())
{
}

WorldServer::~WorldServer()
{
}

void WorldServer::Tick()
{
}
