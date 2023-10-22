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

#include "common/cbasetypes.h"
#include "common/sql.h"
#include "map/besieged_data.h"
#include "message_handler.h"

class BesiegedSystem : public IMessageHandler
{
public:
    BesiegedSystem();
    ~BesiegedSystem() override = default;

    /**
     * IMessageHandler implementation. Used to handle messages from message_server.
     */
    bool handleMessage(HandleableMessage&& message) override;

    /**
     * Called every vana hour (every 2.4 min). Used to send updated stronghold data
     * to all map servers.
     */
    void updateVanaHourlyBesieged();

private:
    std::unique_ptr<SqlConnection> sql;
    std::unique_ptr<BesiegedData>  besiegedData;

    // Methods used for beastmen state updates
    void  updateBeastmenForces();
    float getForcesPerTick(stronghold_info_t strongholdInfo) const;
    void  handleTrainingPhase(stronghold_info_t& strongholdInfo) const;
    void  handlePreparingPhase(stronghold_info_t& strongholdInfo) const;

    void sendStrongholdInfosMsg() const;
};
