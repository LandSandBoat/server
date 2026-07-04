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

struct FlowerPot
{
    uint8_t  Step;
    uint8_t  padding00 : 6;
    uint8_t  Installed : 1;
    uint8_t  Dried : 1;
    uint8_t  Crystal1;
    uint8_t  Crystal2;
    uint8_t  Kind;
    uint8_t  Examined : 1;
    uint8_t  Strength : 7;
    uint8_t  X;
    uint8_t  Z;
    uint8_t  Y;
    uint8_t  Rotation;
    uint16_t padding01;
    uint32_t TimePlanted;
    uint32_t TimeNextStep;
    // Observed as 00 00 00 00 on a freshly placed pot (never planted).
    // Becomes 00 3C 04 08 after the first plant cycle and persists through
    // harvest and subsequent replants. Seen on Ceramic Flowerpot with
    // vegetable seeds (single-feed plant). Purpose unknown.
    uint8_t unknown00[4];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
