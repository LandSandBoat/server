/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "basic.h"

#include <string>

enum OBJECTIVEUTILITY_TYPE : uint8
{
    OBJECTIVEUTILITY_COUNTDOWN = 0x01,
    OBJECTIVEUTILITY_PROGRESS  = 0x02,
    OBJECTIVEUTILITY_HELP      = 0x04,
    OBJECTIVEUTILITY_FENCE     = 0x08
};

class CObjectiveUtilityPacket : public CBasicPacket
{
public:
    CObjectiveUtilityPacket();
    CObjectiveUtilityPacket(uint32 duration, uint32 warning = 0);

    void addCountdown(uint32 duration, uint32 warning = 0);
    void addBars(std::vector<std::pair<std::string, uint32>>&& bars);
    void addScoreboard(const std::pair<int32, int32>& score, const std::vector<uint32>& data);
    void addFence(float x, float y, float radius, float render, bool blue = false);
    void addHelpText(uint16 title, uint16 description);
};
