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
#include "common/taskmgr.h"

#include "besieged_system.h"
#include "campaign_system.h"
#include "colonization_system.h"
#include "conquest_system.h"
#include "http_server.h"
#include "message_server.h"

class WorldServer final : public Application
{
public:
    WorldServer(int argc, char** argv);
    ~WorldServer() override;

    void Tick() override;

    std::unique_ptr<HTTPServer>               httpServer;
    std::unique_ptr<message_server_wrapper_t> messageServer;

    std::unique_ptr<ConquestSystem>     conquestSystem;
    std::unique_ptr<BesiegedSystem>     besiegedSystem;
    std::unique_ptr<CampaignSystem>     campaignSystem;
    std::unique_ptr<ColonizationSystem> colonizationSystem;
};
