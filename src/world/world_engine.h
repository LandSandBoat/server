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

#pragma once

#include "common/application.h"
#include "common/zmq_router_wrapper.h"

#include "http_server.h"

//
// Forward declarations
//

class IPCServer;
class PartySystem;
class ConquestSystem;
class BesiegedSystem;
class CampaignSystem;
class ColonizationSystem;

class WorldEngine final : public Engine
{
public:
    WorldEngine(asio::io_context& io_context);
    ~WorldEngine() override;

    std::unique_ptr<IPCServer> ipcServer_;

    std::unique_ptr<PartySystem> partySystem_;

    std::unique_ptr<ConquestSystem>     conquestSystem_;
    std::unique_ptr<BesiegedSystem>     besiegedSystem_;
    std::unique_ptr<CampaignSystem>     campaignSystem_;
    std::unique_ptr<ColonizationSystem> colonizationSystem_;

    std::unique_ptr<HTTPServer> httpServer_;

private:
    void timeServer(asio::error_code ec);
    void pumpQueues(asio::error_code ec);

    asio::steady_timer m_timeServerTimer;
    asio::steady_timer m_queuePumpTimer;
};
