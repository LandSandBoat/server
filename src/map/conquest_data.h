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
#include "zone.h"

struct region_control_t
{
    uint8 current;
    uint8 prev;
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
    int32 getInfluence(REGION_TYPE region, NATION_TYPE nation) const;

    //
    // Gets the owner of a given region. That is, the one controlling this region since last tally.
    //
    uint8 getRegionOwner(REGION_TYPE region) const;

    //
    // Gets the number of regions controlled by a given nation.
    //
    uint8 getRegionControlCount(NATION_TYPE nation) const;

    //
    // Gets the number of regions controlled by a given nation in the
    // previous tally.
    //
    uint8 getPrevRegionControlCount(NATION_TYPE nation) const;

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
    static int32 CalculateBeastmenInfluence(REGION_TYPE region, const influence_t& influence)
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

        switch (region)
        {
            case REGION_TYPE::RONFAURE:
            case REGION_TYPE::GUSTABERG:
            case REGION_TYPE::SARUTABARUTA:
            {
                homepointKillWeight = 10;
                break;
            }
            case REGION_TYPE::ZULKHEIM:
            case REGION_TYPE::KOLSHUSHU:
            case REGION_TYPE::LITELOR:
            case REGION_TYPE::VOLLBOW:
            {
                homepointKillWeight = 25;
                break;
            }
            case REGION_TYPE::QUFIMISLAND:
            case REGION_TYPE::KUZOTZ:
            case REGION_TYPE::ELSHIMO_LOWLANDS:
            case REGION_TYPE::ELSHIMO_UPLANDS:
            case REGION_TYPE::TAVNAZIA:
            case REGION_TYPE::TULIA: // TODO: Capture correct value
            {
                homepointKillWeight = 50;
                break;
            }
            case REGION_TYPE::NORVALLEN:
            case REGION_TYPE::DERFLAND:
            case REGION_TYPE::ARAGONEU:
            {
                homepointKillWeight = 100;
                break;
            }
            case REGION_TYPE::VALDEAUNIA:
            case REGION_TYPE::FAUREGANDI:
            {
                homepointKillWeight = 150;
                break;
            }
            case REGION_TYPE::MOVALPOLOS:
            {
                homepointKillWeight = 250;
                break;
            }
            default:
            {
                break;
            }
        }

        // Current Beastmen model
        // Beastmen% = Weight * Homepoints / (Weight * Homepoints + MobKills) = BeastmenInfluence / (NationTotal + BeastmenInfluence)
        // BeastmenInfluence = (Weight * Homepoints * NationTotal) / MobKills
        // This will estimate BeastmenInfluence based on the current Nation Total influence
        const int64 beastmenWeight = homepointKillWeight * influence.player_homepoints;

        return static_cast<int32>(std::min<int64>(beastmenWeight * nationTotal / influence.mob_kills, MAX_BEASTMEN_INFLUENCE));
    }

private:
    std::vector<region_control_t> regionControls;
    std::vector<influence_t>      influences;
};
