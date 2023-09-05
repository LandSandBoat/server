/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "conquest_data.h"
#include "zone.h"

enum ConquestUpdate : uint8
{
    Conquest_Tally_Start = 0,
    Conquest_Tally_End   = 1,
    Conquest_Update      = 2
};

class CCharEntity;

/**
 * Conquest System operations for map server.
 * These methods should never update DB. Instead, they should send a message to the world server and
 * let the world server's conquest system perform DB updates.
 */
namespace conquest
{
    std::shared_ptr<ConquestData> GetConquestData(); // Cached data with influences / region controls

    void HandleZMQMessage(uint8* data);

    void UpdateConquestGM(ConquestUpdate type);                  // Update conquest system by GM (modify in the DB and use @updateconquest)
    void GainInfluencePoints(CCharEntity* PChar, uint32 points); // Gain influence for player's nation (+1)
    void LoseInfluencePoints(CCharEntity* PChar);                // Lose influence for player's nation and gain for beastmen influence

    uint8 GetInfluenceGraphics(int32 san_inf, int32 bas_inf, int32 win_inf, int32 bst_inf); // Get number for graphics in conquest menu (arrows)
    uint8 GetInfluenceGraphics(REGION_TYPE RegionID);                                       // Get number for graphics in conquest menu (arrows)
    uint8 GetInfluenceRanking(int32 san_inf, int32 bas_inf, int32 win_inf, int32 bst_inf);
    uint8 GetInfluenceRanking(int32 san_inf, int32 bas_inf, int32 win_inf);

    void HandleInfluenceUpdate(std::vector<influence_t> const& influences, bool shouldUpdateZones); // Triggered periodically when world server sends updates of the latest influence data.
    void HandleWeeklyTallyStart();                                                                  // Triggered on update conquest system every sunday (by world server msg)
    void HandleWeeklyTallyEnd(std::vector<region_control_t> const& regionControls);                 // Triggered when conquest update ends (by world server msg)

    uint8 GetBalance(uint8 sandoria, uint8 bastok, uint8 windurst, // Ranking for 3 nations
                     uint8 sandoria_prev, uint8 bastok_prev, uint8 windurst_prev);
    uint8 GetBalance();
    uint8 GetAlliance(uint8 sandoria, uint8 bastok, uint8 windurst); // Determine if losing nations are allied
    uint8 GetAlliance(uint8 sandoria, uint8 bastok, uint8 windurst,  // Determine if losing nations are allied
                      uint8 sandoria_prev, uint8 bastok_prev, uint8 windurst_prev);
    bool  IsAlliance();                         // Determine if losing nations are allied
    uint8 GetNexTally();                        // Next tally (weekly or every hour ?)
    uint8 GetRegionOwner(REGION_TYPE RegionID); // Get owner of the region

    uint32 AddConquestPoints(CCharEntity* PChar, uint32 exp); // Add conquest points
};                                                            // namespace conquest
