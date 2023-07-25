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
#include "common/logging.h"
#include "time_server.h"

WorldServer::WorldServer(int argc, char** argv)
: Application("world", argc, argv)
, sql(std::make_unique<SqlConnection>())
, httpServer(std::make_unique<HTTPServer>())
, messageServer(std::make_unique<message_server_wrapper_t>(std::ref(m_RequestExit)))
, conquestSystem(std::make_unique<ConquestSystem>())
, besiegedSystem(std::make_unique<BesiegedSystem>())
, campaignSystem(std::make_unique<CampaignSystem>())
, colonizationSystem(std::make_unique<ColonizationSystem>())
{
    // Tasks
    CTaskMgr::getInstance()->AddTask("time_server", server_clock::now(), this, CTaskMgr::TASK_INTERVAL, time_server, 2400ms);
}

WorldServer::~WorldServer() = default;

void WorldServer::Tick()
{
    Application::Tick();
}
