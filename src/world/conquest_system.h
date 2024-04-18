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

#include "map/conquest_system.h"
#include "map/zone.h"
#include "message_handler.h"

/**
 * Conquest System on the world server.
 * This class handles all the DB updates as a response to map server updates.
 */
class ConquestSystem : public IMessageHandler
{
public:
    ConquestSystem();
    ~ConquestSystem() override = default;

    /**
     * IMessageHandler implementation. Used to handle messages from message_server.
     */
    bool handleMessage(HandleableMessage&& message) override;

    /**
     * Called weekly, updates conquest data and sends regional control information
     * to maps servers when done.
     */
    void updateWeekConquest();

    /**
     * Called hourly, updates influence data and sends an immediate influence update
     * message to map servers.
     */
    void updateHourlyConquest();

    /**
     * Called every vana hour (every 2.4 min). Used to send updated influence data
     * to all map servers. Does not request a zone update.
     */
    void updateVanaHourlyConquest();

private:
    bool updateInfluencePoints(int points, unsigned int nation, REGION_TYPE region);

    auto getRegionalInfluences() -> std::vector<influence_t> const;
    auto getRegionControls() -> std::vector<region_control_t> const;

    void sendTallyStartMsg();
    void sendInfluencesMsg(bool shouldUpdateZones, uint64 ipp = 0xFFFF);
    void sendRegionControlsMsg(CONQUESTMSGTYPE msgType, uint64 ipp = 0xFFFF);
};
