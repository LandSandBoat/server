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

struct AssaultLog
{
    uint16_t Flag1 : 1;
    uint16_t Flag2 : 1;
    uint16_t Flag3 : 1;
    uint16_t Flag4 : 1;
    uint16_t Flag5 : 1;
    uint16_t Flag6 : 1;
    uint16_t Flag7 : 1;
    uint16_t Flag8 : 1;
    uint16_t Flag9 : 1;
    uint16_t Flag10 : 1;
    uint16_t padding00 : 6;
    uint8_t  padding01[22];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
