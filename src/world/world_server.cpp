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

#include "besieged_system.h"
#include "campaign_system.h"
#include "colonization_system.h"
#include "conquest_system.h"
#include "http_server.h"
#include "ipc_server.h"
#include "party_system.h"
#include "time_server.h"

int32 pump_queues(time_point tick, CTaskMgr::CTask* PTask)
{
    TracyZoneScoped;

    std::any_cast<WorldServer*>(PTask->m_data)->ipcServer_->handleIncomingMessages();

    return 0;
}

WorldServer::WorldServer(int argc, char** argv)
: Application("world", argc, argv)
, ipcServer_(std::make_unique<IPCServer>(*this))
, partySystem_(std::make_unique<PartySystem>(*this))
, conquestSystem_(std::make_unique<ConquestSystem>(*this))
, besiegedSystem_(std::make_unique<BesiegedSystem>(*this))
, campaignSystem_(std::make_unique<CampaignSystem>(*this))
, colonizationSystem_(std::make_unique<ColonizationSystem>(*this))
, httpServer_(std::make_unique<HTTPServer>())
{
    // Tasks
    CTaskMgr::getInstance()->AddTask("time_server", server_clock::now(), this, CTaskMgr::TASK_INTERVAL, 2400ms, time_server);

    // TODO: Make this more reactive than a polling job
    CTaskMgr::getInstance()->AddTask("pump_queues", server_clock::now(), this, CTaskMgr::TASK_INTERVAL, 250ms, pump_queues);
}

WorldServer::~WorldServer() = default;

void WorldServer::Tick()
{
    Application::Tick();
}
