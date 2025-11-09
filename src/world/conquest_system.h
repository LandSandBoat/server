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

#pragma once

#include "common/regional_event.h"
#include "world_engine.h"

#include "map/conquest_system.h"
#include "map/zone.h"

//
// Conquest System on the world server.
// This class handles all the DB updates as a response to map server updates.
//
class ConquestSystem
{
public:
    ConquestSystem(WorldEngine& worldServer);

    bool handleMessage(uint8 messageType, IPPMessage&& message);

    //
    // Called weekly, updates conquest data and sends regional control information
    // to maps servers when done.
    //
    void updateWeekConquest();

    //
    // Called hourly, updates influence data and sends an immediate influence update
    // message to map servers.
    //
    void updateHourlyConquest();

    //
    // Called every vana hour (every 2.4 min). Used to send updated influence data
    // to all map servers. Does not request a zone update.
    //
    void updateVanaHourlyConquest();

private:
    bool updateInfluencePoints(int points, unsigned int nation, REGION_TYPE region);

    auto getRegionalInfluences() -> const std::vector<influence_t>;
    auto getRegionControls() -> const std::vector<region_control_t>;

    void sendTallyStartMsg();
    void sendInfluencesMsg(bool shouldUpdateZones);
    void sendRegionControlsMsg(ConquestMessage msgType);

    WorldEngine& worldServer_;
};
