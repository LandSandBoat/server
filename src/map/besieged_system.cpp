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

#include "common/settings.h"
#include "map.h"

namespace besieged
{
    static std::shared_ptr<BesiegedData> besiegedData;

    std::shared_ptr<BesiegedData> GetBesiegedData()
    {
        if (besiegedData == nullptr)
        {
            besiegedData = std::make_shared<BesiegedData>(sql);
        }

        return besiegedData;
    }

    /**
     * Called when stronghold updates are received from the world server
     */
    void HandleStrongholdUpdate(std::vector<stronghold_info_t> const& strongHoldInfos)
    {
        TracyZoneScoped;

        if (settings::get<bool>("logging.DEBUG_BESIEGED"))
        {
            ShowInfo("Received besieged Stronghold Data:");
            for (uint8 strongholdId = 0; strongholdId < strongHoldInfos.size(); strongholdId++)
            {
                stronghold_info_t strongholdInfo = strongHoldInfos[strongholdId];
                ShowInfo("Stronghold %d: Orders %d, Level %d, Forces %d, Mirrors %d, Prisoners %d, Owns Astral Candescence %d",
                         strongholdId, strongholdInfo.orders, strongholdInfo.stronghold_level, strongholdInfo.forces, strongholdInfo.mirrors, strongholdInfo.prisoners, strongholdInfo.ownsAstralCandescence);
            }
        }

        GetBesiegedData()->updateStrongholdInfos(strongHoldInfos);
    }

    /**
     * HandleZMQMessage is called by message_server when a besieged ZMQ message is receieved
     */
    void HandleZMQMessage(uint8* data)
    {
        uint8 subtype = ref<uint8>(data, 1);
        switch (subtype)
        {
            case BESIEGED_WORLD2MAP_STRONGHOLD_INFO:
            {
                const std::size_t headerLength    = 2 * sizeof(uint8);
                std::size_t       size            = ref<std::size_t>(data, 2);
                auto              strongholdInfos = std::vector<stronghold_info_t>(size);
                for (std::size_t i = 0; i < size; i++)
                {
                    const std::size_t start = headerLength + sizeof(size_t) + i * sizeof(stronghold_info_t);

                    stronghold_info_t strongholdInfo;
                    strongholdInfo.orders                = (BEASTMEN_BESIEGED_ORDERS)ref<uint8>(data, start);
                    strongholdInfo.stronghold_level      = (STRONGHOLD_LEVEL)ref<uint8>(data, start + 1);
                    strongholdInfo.forces                = ref<uint8>(data, start + 2);
                    strongholdInfo.mirrors               = ref<uint8>(data, start + 3);
                    strongholdInfo.prisoners             = ref<uint8>(data, start + 4);
                    strongholdInfo.ownsAstralCandescence = ref<uint8>(data, start + 6);

                    strongholdInfos[i] = strongholdInfo;
                }

                HandleStrongholdUpdate(strongholdInfos);
                break;
            }
            default:
            {
                ShowError("Unknown besieged message subtype %d", subtype);
            }
        }
    }
} // namespace besieged
