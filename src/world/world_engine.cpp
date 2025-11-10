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

WorldEngine::WorldEngine(asio::io_context& io_context)
: ipcServer_(std::make_unique<IPCServer>(*this))
, partySystem_(std::make_unique<PartySystem>(*this))
, conquestSystem_(std::make_unique<ConquestSystem>(*this))
, besiegedSystem_(std::make_unique<BesiegedSystem>(*this))
, campaignSystem_(std::make_unique<CampaignSystem>(*this))
, colonizationSystem_(std::make_unique<ColonizationSystem>(*this))
, httpServer_(std::make_unique<HTTPServer>())
, m_timeServerTimer(io_context, kTimeServerTickInterval)
, m_queuePumpTimer(io_context, kPumpQueuesTime)
{
    m_timeServerTimer.async_wait(std::bind(&WorldEngine::timeServer, this, std::placeholders::_1));
    // TODO: Bind ZMQ socket FD to ASIO directly
    m_queuePumpTimer.async_wait(std::bind(&WorldEngine::pumpQueues, this, std::placeholders::_1));
}

WorldEngine::~WorldEngine()
{
    m_timeServerTimer.cancel();
    m_queuePumpTimer.cancel();
};

void WorldEngine::timeServer(const asio::error_code ec)
{
    TracyZoneScoped;

    if (!ec)
    {
        time_server(this);

        // Reschedule
        m_timeServerTimer.expires_at(m_timeServerTimer.expiry() + kPumpQueuesTime);
        m_timeServerTimer.async_wait(std::bind(&WorldEngine::timeServer, this, std::placeholders::_1));
    }
}

void WorldEngine::pumpQueues(const asio::error_code ec)
{
    TracyZoneScoped;

    if (!ec)
    {
        ipcServer_->handleIncomingMessages();

        // Reschedule
        m_queuePumpTimer.expires_at(m_queuePumpTimer.expiry() + kPumpQueuesTime);
        m_queuePumpTimer.async_wait(std::bind(&WorldEngine::pumpQueues, this, std::placeholders::_1));
    }
}
