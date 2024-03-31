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

#include "conquest_data.h"

#include "common/cbasetypes.h"
#include "common/database.h"
#include "common/logging.h"
#include "conquest_system.h"

ConquestData::ConquestData()
: regionControls(std::vector<region_control_t>(19))
, influences(std::vector<influence_t>(19))
{
    load();
}

void ConquestData::load()
{
    const char* Query = "SELECT region_id, region_control, region_control_prev, sandoria_influence, bastok_influence, windurst_influence, beastmen_influence \
                         FROM conquest_system";

    auto rset = db::query(Query);
    while (rset && rset->next())
    {
        const auto regionId = rset->getInt("region_id");

        region_control_t regionControl{};
        regionControl.current    = rset->getInt("region_control");
        regionControl.prev       = rset->getInt("region_control_prev");
        regionControls[regionId] = regionControl;

        influence_t influence{};
        influence.sandoria_influence = rset->getInt("sandoria_influence");
        influence.bastok_influence   = rset->getInt("bastok_influence");
        influence.windurst_influence = rset->getInt("windurst_influence");
        influence.beastmen_influence = rset->getInt("beastmen_influence");
        influences[regionId]         = influence;
    }
}

int32 ConquestData::getInfluence(REGION_TYPE region, NATION_TYPE nation) const
{
    if (static_cast<std::size_t>(region) > influences.size() - 1U)
    {
        ShowError("Invalid influence region requested");
        return 0;
    }

    switch (nation)
    {
        case NATION_SANDORIA:
            return influences[(uint8)region].sandoria_influence;
        case NATION_BASTOK:
            return influences[(uint8)region].bastok_influence;
        case NATION_WINDURST:
            return influences[(uint8)region].windurst_influence;
        case NATION_BEASTMEN:
            return influences[(uint8)region].beastmen_influence;
        default:
            ShowWarning("Influence not known for nation: %d", nation);
            return 0;
    }
}

uint8 ConquestData::getRegionOwner(REGION_TYPE region) const
{
    uint8 regionNum = static_cast<uint8>(region);

    if (regionNum < regionControls.size())
    {
        return regionControls[regionNum].current;
    }

    ShowError(fmt::format("Invalid conquest region passed to function ({})", regionNum));
    return 0;
}

uint8 ConquestData::getRegionControlCount(NATION_TYPE nation) const
{
    uint8 count = 0;
    for (const auto& regionControl : regionControls)
    {
        if (regionControl.current == nation)
        {
            count++;
        }
    }

    return count;
}

uint8 ConquestData::getPrevRegionControlCount(NATION_TYPE nation) const
{
    uint8 count = 0;
    for (const auto& regionControl : regionControls)
    {
        if (regionControl.prev == nation)
        {
            count++;
        }
    }

    return count;
}

auto ConquestData::getRegionControls() -> std::vector<region_control_t> const
{
    return regionControls;
}

void ConquestData::addInfluencePoints(int points, NATION_TYPE nation, REGION_TYPE region)
{
    switch (nation)
    {
        case NATION_SANDORIA:
        {
            influences[(uint8)region].sandoria_influence += points;
            break;
        }
        case NATION_BASTOK:
        {
            influences[(uint8)region].bastok_influence += points;
            break;
        }
        case NATION_WINDURST:
        {
            influences[(uint8)region].windurst_influence += points;
            break;
        }
        case NATION_BEASTMEN:
        {
            influences[(uint8)region].beastmen_influence += points;
            break;
        }
        default:
        {
            ShowWarning("Influence not known for nation: %d", nation);
        }
    }
}

void ConquestData::updateInfluencePoints(std::vector<influence_t> const& influencePoints)
{
    influences.clear();
    for (const auto& influence : influencePoints)
    {
        influences.emplace_back(influence);
    }
}

void ConquestData::updateRegionControls(std::vector<region_control_t> const& updatedRegionControls)
{
    regionControls.clear();
    for (const auto& regionControl : updatedRegionControls)
    {
        regionControls.emplace_back(regionControl);
    }
}
