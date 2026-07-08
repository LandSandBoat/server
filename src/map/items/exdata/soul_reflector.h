/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "base.h"

namespace Exdata
{

#pragma pack(push, 1)

struct SoulReflector
{
    uint64_t NameFirst : 6;
    uint64_t NameLast : 6;
    uint64_t PoolId : 16;
    uint64_t Exp : 8;
    uint64_t Discipline : 8;     // Discipline accumulator. /16 = display index (0=extremely low .. 7=extremely high)
    uint64_t Temperament : 4;    // Tame/wild axis. /2 = display index (0=extremely tame .. 7=extremely wild)
    uint64_t Aggressiveness : 4; // Aggressive/defensive axis. /2 = display index (0=extremely defensive .. 7=extremely aggressive)
    uint64_t Level : 7;

    // Feral skill bitstream: 7 x 19-bit slots
    // 1-5: equipped skills
    // 6-7: innate species abilities
    // Each slot: FeralSkillId:12 + SkillLevel:7
    uint64_t feralSkillStream0 : 5;
    uint8_t  feralSkillStream1[16];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
