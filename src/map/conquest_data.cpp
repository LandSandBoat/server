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
    const auto rset = db::preparedStmt("SELECT region_id, region_control, region_control_prev, sandoria_influence, bastok_influence, windurst_influence, mob_kills, player_homepoints "
                                       "FROM conquest_system");
    while (rset && rset->next())
    {
        const auto regionId = rset->get<uint32>("region_id");

        region_control_t regionControl{};
        regionControl.current    = rset->get<xi::Nation>("region_control");
        regionControl.prev       = rset->get<xi::Nation>("region_control_prev");
        regionControls[regionId] = regionControl;

        influence_t influence{};
        influence.sandoria_influence = rset->get<int32>("sandoria_influence");
        influence.bastok_influence   = rset->get<int32>("bastok_influence");
        influence.windurst_influence = rset->get<int32>("windurst_influence");
        influence.mob_kills          = rset->get<int32>("mob_kills");
        influence.player_homepoints  = rset->get<int32>("player_homepoints");
        influences[regionId]         = influence;
    }
}

auto ConquestData::getInfluence(const xi::Region region, const xi::Nation nation) const -> int32
{
    if (static_cast<std::size_t>(region) >= influences.size())
    {
        ShowError("Invalid influence region requested");
        return 0;
    }

    switch (nation)
    {
        case xi::Nation::Sandoria:
            return influences[(uint8)region].sandoria_influence;
        case xi::Nation::Bastok:
            return influences[(uint8)region].bastok_influence;
        case xi::Nation::Windurst:
            return influences[(uint8)region].windurst_influence;
        case xi::Nation::Beastmen:
            return CalculateBeastmenInfluence(region, influences[(uint8)region]);
        default:
            ShowWarningFmt("Influence not known for nation: {}", nation);
            return 0;
    }
}

auto ConquestData::getRegionOwner(const xi::Region region) const -> xi::Nation
{
    uint8 regionNum = static_cast<uint8>(region);

    // Handle some conquest regions that don't have conquest info as non-error
    // TODO: Do Sandoria/Bastok/Windurst count as "owned by" themselves, no one, or some other state where latents don't work?
    switch (region)
    {
        case xi::Region::Sandoria:
        case xi::Region::Bastok:
        case xi::Region::Windurst:
        case xi::Region::Jeuno:
        case xi::Region::Dynamis:
        case xi::Region::TavnazianMarquisate:
        case xi::Region::Promyvion:
        case xi::Region::Lumoria:
        case xi::Region::Limbus:
            return xi::Nation::Beastmen;
        default:
            if (regionNum < regionControls.size())
            {
                return regionControls[regionNum].current;
            }
    }

    ShowError(fmt::format("Invalid conquest region passed to function ({})", regionNum));
    return xi::Nation::Sandoria;
}

auto ConquestData::getRegionControlCount(const xi::Nation nation) const -> uint8
{
    return static_cast<uint8>(std::ranges::count(regionControls, nation, &region_control_t::current));
}

auto ConquestData::getPrevRegionControlCount(const xi::Nation nation) const -> uint8
{
    return static_cast<uint8>(std::ranges::count(regionControls, nation, &region_control_t::prev));
}

auto ConquestData::getRegionControls() const -> const std::vector<region_control_t>&
{
    return regionControls;
}

void ConquestData::updateInfluencePoints(const std::vector<influence_t>& influencePoints)
{
    influences.clear();
    for (const auto& influence : influencePoints)
    {
        influences.emplace_back(influence);
    }
}

void ConquestData::updateRegionControls(const std::vector<region_control_t>& updatedRegionControls)
{
    regionControls.clear();
    for (const auto& regionControl : updatedRegionControls)
    {
        regionControls.emplace_back(regionControl);
    }
}
