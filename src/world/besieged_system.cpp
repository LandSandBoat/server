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

#include "besieged_system.h"
#include "common/mmo.h"
#include "common/settings.h"
#include "common/socket.h"
#include "map/besieged_data.h"
#include "world/message_server.h"

BesiegedSystem::BesiegedSystem()
: sql(std::make_unique<SqlConnection>())
{
}

bool BesiegedSystem::handleMessage(std::vector<uint8>&& payload,
                                   in_addr              from_addr,
                                   uint16               from_port)
{
    // TODO: Handle incoming map messages
    if (settings::get<bool>("logging.DEBUG_BESIEGED"))
    {
        ShowDebug(fmt::format("Message: unknown conquest type received from {}:{}",
                              from_addr.s_addr,
                              from_port));
    }

    return false;
}

void BesiegedSystem::updateVanaHourlyBesieged()
{
    auto strongholdInfos = this->getStrongholdInfos();

    // Note to reviewer: logging.DEBUG_BESIEGED is not read properly from world.
    // It is from map. Other settings in world seem to use main.conf
    if (settings::get<bool>("logging.DEBUG_BESIEGED"))
    {
        ShowInfo("Sending besieged Stronghold Data:");
        for (uint8 strongholdId = 0; strongholdId < strongholdInfos.size(); strongholdId++)
        {
            stronghold_info_t strongholdInfo = strongholdInfos[strongholdId];
            ShowInfo("Stronghold %d: Orders %d, Level %d, Forces %d, Mirrors %d, Prisoners %d, Owns Astral Candescence %d",
                     strongholdId, strongholdInfo.orders, strongholdInfo.stronghold_level, strongholdInfo.forces, strongholdInfo.mirrors, strongholdInfo.prisoners, strongholdInfo.ownsAstralCandescence);
        }
    }

    // Base length is the type + subtype + vector size
    const std::size_t headerLength = 2 * sizeof(uint8);
    const std::size_t dataLen      = headerLength + sizeof(size_t) + sizeof(stronghold_info_t) * strongholdInfos.size();
    const uint8*      data         = new uint8[dataLen];

    // Regional event type + besieged msg type
    ref<uint8>((uint8*)data, 0) = REGIONAL_EVT_MSG_BESIEGED;
    ref<uint8>((uint8*)data, 1) = BESIEGED_WORLD2MAP_STRONGHOLD_INFO;

    // Size info for deserialization
    ref<std::size_t>((uint8*)data, 2) = strongholdInfos.size();

    for (std::size_t i = 0; i < strongholdInfos.size(); i++)
    {
        // Everything is offset by i*size of region control struct + headerLength
        // Every field is one byte, so we can just add the offset to the start of the data
        const std::size_t start             = headerLength + sizeof(size_t) + i * sizeof(stronghold_info_t);
        ref<uint8>((uint8*)data, start)     = strongholdInfos[i].orders;
        ref<uint8>((uint8*)data, start + 1) = strongholdInfos[i].stronghold_level;
        ref<uint8>((uint8*)data, start + 2) = strongholdInfos[i].forces;
        ref<uint8>((uint8*)data, start + 3) = strongholdInfos[i].mirrors;
        ref<uint8>((uint8*)data, start + 4) = strongholdInfos[i].prisoners;
        ref<uint8>((uint8*)data, start + 6) = strongholdInfos[i].ownsAstralCandescence;
    }

    // Send to map
    queue_data_broadcast(MSG_WORLD2MAP_REGIONAL_EVENT, data, dataLen);
}

auto BesiegedSystem::getStrongholdInfos() -> std::vector<stronghold_info_t> const
{
    const char* Query = "SELECT stronghold_id, orders, stronghold_level, forces, prisoners, owns_astral_candescence, \
                        (SELECT COUNT(*) FROM besieged_mirrors WHERE destroyed = 0 AND besieged_mirrors.stronghold_id = besieged_strongholds.stronghold_id) AS mirrors \
                        FROM besieged_strongholds;";

    int32                          ret             = sql->Query(Query);
    const std::size_t              strongholdCount = 4;
    std::vector<stronghold_info_t> strongholdInfos(strongholdCount);

    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            uint8 strongholdId = sql->GetUIntData(0);
            if (strongholdId > 3)
            {
                ShowError("Invalid stronghold id %d", strongholdId);
                throw std::runtime_error("Besieged stronghold id out of range");
            }

            stronghold_info_t strongholdInfo;
            strongholdInfo.orders                = sql->GetUIntData<BEASTMEN_BESIEGED_ORDERS>(1);
            strongholdInfo.stronghold_level      = sql->GetUIntData<STRONGHOLD_LEVEL>(2);
            strongholdInfo.forces                = sql->GetUIntData(3);
            strongholdInfo.prisoners             = sql->GetUIntData(4);
            strongholdInfo.ownsAstralCandescence = sql->GetUIntData(5);
            strongholdInfo.mirrors               = sql->GetUIntData(6);

            strongholdInfos[sql->GetUIntData(0)] = strongholdInfo;
        }
    }

    return strongholdInfos;
}
