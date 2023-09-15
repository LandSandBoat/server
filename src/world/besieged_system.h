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
     * NOTE: The copy of payload here is intentional, since these systems will eventually
     *     : be moved to their own threads.
     */
    bool handleMessage(std::vector<uint8>&& payload,
                       in_addr              from_addr,
                       uint16               from_port) override;

    /**
     * Called every vana hour (every 2.4 min). Used to send updated stronghold data
     * to all map servers.
     */
    void updateVanaHourlyBesieged();

private:
    std::unique_ptr<SqlConnection> sql;
    auto                           getStrongholdInfos() -> std::vector<stronghold_info_t> const;
};
