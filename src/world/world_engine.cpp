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

#include "world_engine.h"

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

constexpr auto kTimeServerTickInterval = 2400ms;
constexpr auto kPumpQueuesTime         = 250ms;

} // namespace

WorldEngine::WorldEngine(Scheduler& scheduler)
: scheduler_(scheduler)
, ipcServer_(std::make_unique<IPCServer>(*this))
, partySystem_(std::make_unique<PartySystem>(*this))
, conquestSystem_(std::make_unique<ConquestSystem>(*this))
, besiegedSystem_(std::make_unique<BesiegedSystem>(*this))
, campaignSystem_(std::make_unique<CampaignSystem>(*this))
, colonizationSystem_(std::make_unique<ColonizationSystem>(*this))
, httpServer_(std::make_unique<HTTPServer>())
{
    scheduler_.postToMainThread(timeServer());

    // TODO: Bind ZMQ socket FD to ASIO directly
    scheduler_.postToMainThread(pumpQueues());
}

WorldEngine::~WorldEngine() = default;

auto WorldEngine::timeServer() -> Task<void>
{
    while (!scheduler_.closeRequested())
    {
        co_await scheduler_.yieldFor(kTimeServerTickInterval);

        if (!scheduler_.closeRequested())
        {
            time_server(this);
        }
    }
}

auto WorldEngine::pumpQueues() -> Task<void>
{
    while (!scheduler_.closeRequested())
    {
        co_await scheduler_.yieldFor(kPumpQueuesTime);

        if (!scheduler_.closeRequested())
        {
            ipcServer_->handleIncomingMessages();
        }
    }
}
