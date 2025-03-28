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

namespace
{
    static constexpr auto kTimeServerTickTime = 2400ms;
    static constexpr auto kPumpQueuesTime     = 250ms;
    static constexpr auto kMainTickTime       = 200ms;
} // namespace

/*
void pump_queues(WorldServer* worldServer, asio::steady_timer* timer)
{
    TracyZoneScoped;

    worldServer->ipcServer_->handleIncomingMessages();

    if (worldServer->isRunning())
    {
        // reset timer
        timer->expires_at(timer->expiry() + kPumpQueuesTime);
        timer->async_wait(std::bind(&pump_queues, worldServer, timer));
    }
}
*/

int32 pump_queues(time_point tick, CTaskManager::CTask* PTask)
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
    CTaskManager::getInstance()->AddTask("time_server", server_clock::now(), this, CTaskManager::TASK_INTERVAL, kTimeServerTickTime, time_server);

    // TODO: Make this more reactive than a polling job
    CTaskManager::getInstance()->AddTask("pump_queues", server_clock::now(), this, CTaskManager::TASK_INTERVAL, kPumpQueuesTime, pump_queues);

    // asio::steady_timer timeServerTimer(io_context_, kPumpQueuesTime);
    // timeServerTimer.async_wait(std::bind(&pump_queues, this, &timeServerTimer));
}

WorldServer::~WorldServer() = default;

void WorldServer::loadConsoleCommands()
{
}

void WorldServer::run()
{
    Application::markLoaded();

    while (Application::isRunning())
    {
        const auto tickStart     = server_clock::now();
        const auto tasksDuration = CTaskManager::getInstance()->doExpiredTasks(tickStart);
        const auto sleepFor      = kMainTickTime - tasksDuration;
        std::this_thread::sleep_for(sleepFor);
    }
}
