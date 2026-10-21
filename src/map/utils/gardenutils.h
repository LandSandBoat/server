/*
===========================================================================

  Copyright (c) 2010-2018 Darkstar Dev Teams

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

  This file is part of DarkStar-server source code.

===========================================================================
*/

#pragma once

#include "common/cbasetypes.h"

class CCharEntity;
class CItemFlowerpot;

struct GardenResult_t
{
    GardenResult_t();
    GardenResult_t(uint16 ItemID, uint8 MinQuantity, uint8 MaxQuantity, uint8 Weight);
    uint16 ItemID      = 0;
    uint8  MinQuantity = 0;
    uint8  MaxQuantity = 0;
    uint8  Weight      = 0;
};

using GardenResultList_t = std::vector<GardenResult_t>;

namespace gardenutils
{

void Initialize();

void UpdateGardening(CCharEntity* PChar, SendPacket sendPacket);
auto CalculateResults(CCharEntity* PChar, CItemFlowerpot* PItem) -> std::tuple<uint16, uint8>;
void GrowToNextStage(CItemFlowerpot* PItem, bool growFromFeed = false);
auto GetStageDuration(CItemFlowerpot* PItem, bool growFromFeed = false) -> uint8;

} // namespace gardenutils
