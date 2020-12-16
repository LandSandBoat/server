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

#ifndef _CONQUESTSYSTEM_H
#define _CONQUESTSYSTEM_H

#include "../common/cbasetypes.h"

#include "zone.h"

#define NATION_SANDORIA 0x00
#define NATION_BASTOK   0x01
#define NATION_WINDURST 0x02
#define NATION_BEASTMEN 0x03
#define NATION_NEUTRAL  0xFF

enum ConquestUpdate : uint8
{
    Conquest_Tally_Start = 0,
    Conquest_Tally_End   = 1,
    Conquest_Update      = 2
};

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

class CCharEntity;

namespace conquest
{
    void UpdateConquestSystem(); // Update conquest information in the DB

    void UpdateInfluencePoints(int points, unsigned int nation, unsigned int region);
    void GainInfluencePoints(CCharEntity* PChar, uint32 points); // Gain influence for player's nation (+1)
    void LoseInfluencePoints(CCharEntity* PChar);                // Lose influence for player's nation and gain for beastmen influence

    uint8 GetInfluenceGraphics(int32 san_inf, int32 bas_inf, int32 win_inf, int32 bst_inf); // Get number for graphics in conquest menu (arrows)
    uint8 GetInfluenceGraphics(REGIONTYPE RegionID);                                        // Get number for graphics in conquest menu (arrows)
    uint8 GetInfluenceRanking(int32 san_inf, int32 bas_inf, int32 win_inf, int32 bst_inf);
    uint8 GetInfluenceRanking(int32 san_inf, int32 bas_inf, int32 win_inf);

    void UpdateConquestGM(ConquestUpdate type); // Update conquest system by GM (modify in the DB and use @updateconquest)
    void UpdateWeekConquest();                  // Update conquest system every sunday

    uint8 GetBalance(uint8 sandoria, uint8 bastok, uint8 windurst, // Ranking for 3 nations
                     uint8 sandoria_prev, uint8 bastok_prev, uint8 windurst_prev);
    uint8 GetBalance();
    uint8 GetAlliance(uint8 sandoria, uint8 bastok, uint8 windurst); // Determine if losing nations are allied
    uint8 GetAlliance(uint8 sandoria, uint8 bastok, uint8 windurst,  // Determine if losing nations are allied
                      uint8 sandoria_prev, uint8 bastok_prev, uint8 windurst_prev);
    bool  IsAlliance();                        // Determine if losing nations are allied
    uint8 GetNexTally();                       // Next tally (weekly or every hour ?)
    uint8 GetRegionOwner(REGIONTYPE RegionID); // Get owner of the region

    uint32 AddConquestPoints(CCharEntity* PChar, uint32 exp); // Add conquest points
};                                                            // namespace conquest

#endif
