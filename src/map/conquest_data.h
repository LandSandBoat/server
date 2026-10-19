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

#include <string>

#include "common/cbasetypes.h"
#include "common/database.h"
#include "data/enums/nation.h"
#include "zone.h"

struct region_control_t
{
    xi::Nation current;
    xi::Nation prev;
};

struct influence_t
{
    int32 sandoria_influence;
    int32 bastok_influence;
    int32 windurst_influence;
    int32 mob_kills;
    int32 player_homepoints;
};

//
// Conquest Data that is cached by the map server. This data is used to avoid redundant DB reads.
// Conquest data should be update periodically, as a result of influence / regional control updates
// received by the world server's conquest system.
//
class ConquestData
{
public:
    ConquestData();

    //
    // Gets the influence points for a given nation in a given region.
    //
    auto getInfluence(xi::Region region, xi::Nation nation) const -> int32;

    //
    // Gets the owner of a given region. That is, the one controlling this region since last tally.
    //
    auto getRegionOwner(xi::Region region) const -> xi::Nation;

    //
    // Gets the number of regions controlled by a given nation.
    //
    auto getRegionControlCount(xi::Nation nation) const -> uint8;

    //
    // Gets the number of regions controlled by a given nation in the
    // previous tally.
    //
    auto getPrevRegionControlCount(xi::Nation nation) const -> uint8;

    //
    // Gets the array of region controls, indexed by regionId.
    //
    auto getRegionControls() const -> const std::vector<region_control_t>&;

    //
    // Updates the influence points to match those given.
    //
    void updateInfluencePoints(const std::vector<influence_t>& influencePoints);

    //
    // Updates region controls to match those given.
    //
    void updateRegionControls(const std::vector<region_control_t>& regionControls);

    //
    // Calculates how much influence the beastmen hold in a region based on mob kills and homepoints.
    //
    static auto CalculateBeastmenInfluence(const xi::Region region, const influence_t& influence) -> int32
    {
        if (influence.player_homepoints == 0)
        {
            return 0;
        }

        // No mob kills means beastmen own 100% if a homepoint has happened
        constexpr int32 MAX_BEASTMEN_INFLUENCE = INT32_MAX / 100; // Packet multiplies by 100
        if (influence.mob_kills == 0)
        {
            return MAX_BEASTMEN_INFLUENCE;
        }

        const int64 nationTotal = influence.sandoria_influence + influence.bastok_influence + influence.windurst_influence;
        if (nationTotal == 0)
        {
            return MAX_BEASTMEN_INFLUENCE;
        }

        // Specify the homepoint to kill ratio based on region. One homepoint equals this many mob kills.
        int64 homepointKillWeight = 0;

        // Original regions were grouped as general, semi-stronghold, and stronghold.
        switch (region)
        {
            // General
            case xi::Region::Ronfaure:
            case xi::Region::Zulkheim:
            case xi::Region::Gustaberg:
            case xi::Region::Sarutabaruta:
            case xi::Region::Kolshushu:
            {
                homepointKillWeight = 10;
                break;
            }
            // Semi-stronghold
            case xi::Region::Fauregandi:
            case xi::Region::QufimIsland:
            case xi::Region::Litelor:
            case xi::Region::Kuzotz:
            case xi::Region::Vollbow:
            case xi::Region::ElshimoLowlands:
            case xi::Region::ElshimoUplands:
            case xi::Region::Tulia:
            case xi::Region::TavnazianArchipelago:
            {
                homepointKillWeight = 25;
                break;
            }
            // Stronghold
            case xi::Region::Norvallen:
            case xi::Region::Derfland:
            case xi::Region::Aragoneu:
            case xi::Region::Valdeaunia:
            case xi::Region::Movalpolos:
            {
                homepointKillWeight = 50;
                break;
            }
            default:
            {
                homepointKillWeight = 10;
                break;
            }
        }

        // Current Beastmen model
        // Beastmen% = Homepoints / (1 + Homepoints + MobKills / Weight) = BeastmenInfluence / (NationTotal + BeastmenInfluence)
        // BeastmenInfluence = (Weight * Homepoints * NationTotal) / (Weight + MobKills)
        // This will estimate BeastmenInfluence based on the current Nation Total influence
        const int64 beastmenWeight = homepointKillWeight * influence.player_homepoints;

        return static_cast<int32>(std::min<int64>(beastmenWeight * nationTotal / (influence.mob_kills + homepointKillWeight), MAX_BEASTMEN_INFLUENCE));
    }

private:
    std::vector<region_control_t> regionControls;
    std::vector<influence_t>      influences;
};
